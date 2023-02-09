import boto3

def lambda_handler(event, context):
    # Get the responsePayload from the original SNS message
    responsePayload = event['Records'][0]['Sns']['Message'][]
    
    # Send the responsePayload to a new SNS topic
    sns = boto3.client('sns')
    email_subject = "Word Count Result"
    email_message = responsePayload
    response = sns.publish(TopicArn="arn:aws:sns:us-west-2:018062341690:snsformated", 
                           Message=email_message, Subject=email_subject)
    if response['ResponseMetadata']['HTTPStatusCode'] == 200:
        print("Result sent successfully")
    else:
        print("Result sending failed")
