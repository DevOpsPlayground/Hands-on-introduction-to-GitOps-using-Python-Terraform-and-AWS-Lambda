import os

import boto3

import random
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


def lambda_handler(event, context):
    print(event)
    item_description = json.loads(event['body'])['item_description']

    # Each item needs a unique key - item_id
    # So we'll just iterate over randoms until one is found that doesn't exist already
    #
    # .... it does the job okay
    found = False
    item_id = None

    while not found:
        random_id = random.randint(0, 100000000)

        response = client.query(
            TableName=dynamodb_table,
            KeyConditionExpression='item_id = :item_id',
            ExpressionAttributeValues={
                ':item_id': {'N': str(random_id)}
            }
        )

        if len(response['Items']) == 0:
            # Found an unused ID!
            item_id = random_id
            found = True

    response = table.put_item(
        Item={
            'item_id': item_id,
            'item_description': item_description,
            'item_status': "TODO"
        }
    )

    return {
        "headers": {
            "Access-Control-Allow-Headers": "Content-Type,X-Amz-Date,X-Amz-Security-Token,Authorization,X-Api-Key,X-Requested-With,Accept,Access-Control-Allow-Methods,Access-Control-Allow-Origin,Access-Control-Allow-Headers",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "OPTIONS,POST"
        },
        "statusCode": 200,
        "body": json.dumps({
            'item_id': item_id,
            'item_description': item_description,
            'item_status': "TODO"
        }),
        "isBase64Encoded": False
    }
