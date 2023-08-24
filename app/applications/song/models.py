from django.db import models

from applications.singer.models import Singer


class Song(models.Model):
    title = models.CharField(max_length=120)
    album = models.ForeignKey('Album', on_delete=models.CASCADE, related_name='songs')
    track_number = models.PositiveIntegerField()
    singer = models.ManyToManyField(Singer, related_name='songs')

    def __str__(self):
        return self.title


class Album(models.Model):
    singer = models.ForeignKey(Singer, related_name='albums', on_delete=models.CASCADE)
    title = models.CharField(max_length=120)
    release_year = models.DateTimeField()

    def __str__(self):
        return self.title
