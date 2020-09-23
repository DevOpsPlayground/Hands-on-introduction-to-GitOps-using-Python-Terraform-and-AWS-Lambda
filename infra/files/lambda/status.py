import os

import boto3
import json

dynamodb_table = os.getenv("DYNAMODB_DB_TABLE_NAME")

client = boto3.client("dynamodb")

dynamodb = boto3.resource("dynamodb")

table = dynamodb.Table(dynamodb_table)


def lambda_handler(event, context):
    print(event)

    # Expects event:
    # ItemStatusRequest
    # {
    #   "item_id": <EXISTING ITEM ID>,
    #   "item_status" <[TODO|INPROGRESS|DONE]>
    # }
    #

    item_id = event['pathParameters']['item_id']

    new_status = event['resource'].replace("/item/{item_id}/", "")

    # determine new status for REST endpoint
    if new_status == "start":
        new_status = "INPROGRESS"

    if new_status == "stop":
        new_status = "TODO"

    if new_status == "done":
        new_status = "DONE"

    # get current status
    response = table.query(
        KeyConditionExpression='item_id = :item_id',
        ExpressionAttributeValues={
            ':item_id': int(item_id)
        }
    )

    # Validate statuses
    status = response['Items'][0]['item_status']

    if status in ("TODO", "DONE") and new_status in ("TODO", "DONE"):
        return "Nope"

    if status == "INPROGRESS" and new_status == "INPROGRESS":
        return "Nope"

    # update status
    response = table.update_item(
        Key={
            'item_id': int(item_id)
        },
        UpdateExpression="set item_status=:item_status",
        ExpressionAttributeValues={
            ':item_status': new_status
        },
    )

    return {
        "headers": {
            "Access-Control-Allow-Headers": "Content-Type,X-Amz-Date,X-Amz-Security-Token,Authorization,X-Api-Key,X-Requested-With,Accept,Access-Control-Allow-Methods,Access-Control-Allow-Origin,Access-Control-Allow-Headers",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "OPTIONS,POST,GET,DELETE"
        },
        "isBase64Encoded": False,
        "statusCode": 200,
        "body": json.dumps({"item_id": item_id, "item_status": new_status})
    }
