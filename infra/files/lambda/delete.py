import os

import boto3
import json

dynamodb_table = os.getenv("DYNAMODB_DB_TABLE_NAME")

client = boto3.client("dynamodb")

dynamodb = boto3.resource("dynamodb")

table = dynamodb.Table(dynamodb_table)


def lambda_handler(event, context):
    print(event)

    item_id = event['pathParameters']['item_id']

    response = table.delete_item(
        Key={
            'item_id': int(item_id)
        }
    )

    return {
        "headers": {
            "Access-Control-Allow-Headers": "Content-Type,X-Amz-Date,X-Amz-Security-Token,Authorization,X-Api-Key,X-Requested-With,Accept,Access-Control-Allow-Methods,Access-Control-Allow-Origin,Access-Control-Allow-Headers",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "OPTIONS,POST,GET,DELETE"
        },
        "statusCode": 200,
        "body": "ok"
    }
