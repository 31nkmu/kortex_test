from django.contrib import admin

from applications.song.models import Album, Song

admin.site.register(Album)
admin.site.register(Song)
