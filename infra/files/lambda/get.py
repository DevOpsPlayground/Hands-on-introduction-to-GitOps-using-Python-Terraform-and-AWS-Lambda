import os

import boto3
import json


dynamodb_table = os.getenv("DYNAMODB_DB_TABLE_NAME")

client = boto3.client("dynamodb")

dynamodb = boto3.resource("dynamodb")

table = dynamodb.Table(dynamodb_table)

#####
# Triggered by POST
#
# Model:
# {"description": STRING}
#
#


def decode_item(item):
    return {
        "item_id": item['item_id']['N'],
        "item_description": item['item_description']['S'],
        "item_status": item['item_status']['S'],
    }


def lambda_handler(event, context):
    print(event)
    response = client.query(
        TableName=dynamodb_table,
        KeyConditionExpression='item_id = :item_id',
        ExpressionAttributeValues={
            ':item_id': {'N': event['pathParameters']['item_id']}
        }
    )

    print(response)

    item = decode_item(response['Items'][0])

    return {
        "headers": {
            "Access-Control-Allow-Headers": "Content-Type,X-Amz-Date,X-Amz-Security-Token,Authorization,X-Api-Key,X-Requested-With,Accept,Access-Control-Allow-Methods,Access-Control-Allow-Origin,Access-Control-Allow-Headers",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "OPTIONS,POST,GET,DELETE"
        },
        "statusCode": 200,
        "body": json.dumps(item)
    }
