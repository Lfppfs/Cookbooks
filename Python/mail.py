def mail_function():
    import smtplib
    mailer = smtplib.SMTP('smtp.gmail.com', 587)
    mailer.ehlo()
    mailer.starttls()
    mailer.login('pythondoluis@gmail.com', 'python4160')
    mailer.sendmail('pythondoluis@gmail.com', 'lfppfs@gmail.com',
                    'Subject: Your iPython cell is finished')
    mailer.quit()


mail_function()
