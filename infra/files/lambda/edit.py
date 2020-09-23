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

    item_description = json.loads(event['body'])['item_description']

    # Validate status

    response = table.update_item(
        Key={
            'item_id': int(item_id)
        },
        UpdateExpression="set item_description=:d",
        ExpressionAttributeValues={
            ':d': item_description
        },
    )

    return {
        "statusCode": 200,
        "body": json.dumps({
            "item_id": item_id,
            "item_description": item_description
        })
    }
