import boto3

session = boto3.Session(
    aws_access_key_id="AKIA6ODU75VINENSSC7B",
    aws_secret_access_key="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",
)


class Image:
    def UploadImage(name: str, company: str, image):
        print("SWAAAAAG")
        # Förhindra att man kan sätta in wonky namn
        filename = company + "_" + name + ".png"
        imagedata = image.read()
        s3 = session.resource("s3")

        object = s3.Object("eatwisebucket", filename)
        object.put(ACL="public-read", Body=imagedata, Key=filename)
        return True
