import json
import urllib.parse
import boto3
import re

print('Loading function')

s3 = boto3.client('s3')


def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))

    # Get the object from the event and show its content type
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
   
    response = s3.get_object(Bucket=bucket, Key=key)
    print("CONTENT TYPE: " + response['ContentType'])
   
        
    file_content = response['Body'].read().decode('utf-8')
    # Count the number of words
    word_list = re.findall(r'\w+', file_content)
    word_count = len(word_list)
    return "The word count in the file {} is {}".format(key, word_count)
