### Send mail via Amazon SES
1. AWS IAM User (AKSK)
```py
import boto3
from botocore.exceptions import ClientError

### Need to in SES Identities to verify the email address
SENDER = "mail@example.com"
### If not in SES Identities, will get error: 554 Message rejected: Email address is not verified.
### An error occurred while sending the email: (554, b'Message rejected: Email address is not verified.
### The following identities failed the check in region US-WEST-2: mail@example.com')
### Need to in SES Identities to verify the email address

### Maybe mail will in spam folder
RECIPIENT = "neil.kuan@mail.com"
### Maybe mail will in spam folder

# If necessary, replace us-west-2 with the AWS Region you're using for Amazon SES.
AWS_REGION = "us-west-2"

# The subject line for the email.
SUBJECT = "Amazon SES Test (SDK for Python)"

# The email body for recipients with non-HTML email clients.
BODY_TEXT = ("Amazon SES Test (Python)\r\n"
             "This email was sent with Amazon SES using the "
             "AWS SDK for Python (Boto)."
            )
            
BODY_HTML = """<html>
<head></head>
<body>
  <h1>Amazon SES Test (SDK for Python)</h1>
  <p>This email was sent with
    <a href='https://aws.amazon.com/ses/'>Amazon SES</a> using the
    <a href='https://aws.amazon.com/sdk-for-python/'> AWS SDK for Python (Boto)</a>.</p>
</body>
</html>
"""            
CHARSET = "UTF-8"

# Create a new SES resource and specify a region.
client = boto3.client('ses',region_name=AWS_REGION)

# Try to send the email.
try:
    #Provide the contents of the email.
    response = client.send_email(
        Destination={
            'ToAddresses': [
                RECIPIENT,
            ],
        },
        Message={
            'Body': {
                'Html': {
                    'Charset': CHARSET,
                    'Data': BODY_HTML,
                },
                'Text': {
                    'Charset': CHARSET,
                    'Data': BODY_TEXT,
                },
            },
            'Subject': {
                'Charset': CHARSET,
                'Data': SUBJECT,
            },
        },
        Source=SENDER,
    )
# Display an error if something goes wrong.	
except ClientError as e:
    print(e.response['Error']['Message'])
else:
    print("Email sent! Message ID:"),
    print(response['MessageId'])
```

2. AWS STMP IAM User (smtp-credentials)
   - docs: https://docs.aws.amazon.com/zh_tw/ses/latest/dg/smtp-credentials.html
   - need permission
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ses:SendRawEmail",
            "Resource": "*"
        }
    ]
}
```

```py
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# 設定 SMTP 伺服器參數
smtp_server = 'email-smtp.us-west-2.amazonaws.com'
smtp_port = 587  # 使用 STARTTLS 的端口
username = "AKIXXXXXXXXXXXXXXX"
password = "BXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

### Need to in SES Identities to verify the email address
SENDER = "mail@example.com"
### If not in SES Identities, will get error: 554 Message rejected: Email address is not verified.
### An error occurred while sending the email: (554, b'Message rejected: Email address is not verified.
### The following identities failed the check in region US-WEST-2: mail@example.com')
### Need to in SES Identities to verify the email address

### Maybe mail will in spam folder
RECIPIENT = "neil.kuan@mail.com"
### Maybe mail will in spam folder

# If necessary, replace us-west-2 with the AWS Region you're using for Amazon SES.
AWS_REGION = "us-west-2"

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# 設定 SMTP 伺服器參數
smtp_server = 'email-smtp.us-west-2.amazonaws.com'
smtp_port = 587  # 使用 STARTTLS 的端口

# 設定郵件內容
sender_email = SENDER
receiver_email = SENDER
subject = 'Test Email'
body = 'This is a test email sent using AWS SES with smtplib in Python.'
# 建立郵件訊息
message = MIMEMultipart()
message['From'] = sender_email
message['To'] = receiver_email
message['Subject'] = subject
message.attach(MIMEText(body, 'plain'))

try:
    # 連接到 SMTP 伺服器並發送郵件
    server = smtplib.SMTP(smtp_server, smtp_port, timeout=10)  # 使用 SMTP 連接
    server.starttls()  # 啟用 TLS 加密
    server.login(username, password)
    server.sendmail(sender_email, receiver_email, message.as_string())
    print('Email sent successfully!')
except Exception as e:
    print(f'An error occurred while sending the email: {e}')
finally:
    server.quit()

```
