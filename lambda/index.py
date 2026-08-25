import json

def handler(event, context):
    name = event.get("name", "World")
    message = f"Hello, {name} from local AWS Lambda!"

    return {
        "statusCode": 200,
        "body": json.dumps({"message": message})
    }
