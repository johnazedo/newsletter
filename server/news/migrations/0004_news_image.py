# Generated by Django 3.2 on 2021-04-18 04:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('news', '0003_news_comments'),
    ]

    operations = [
        migrations.AddField(
            model_name='news',
            name='image',
            field=models.ImageField(default='/media/teste.jpg', upload_to=''),
        ),
    ]
