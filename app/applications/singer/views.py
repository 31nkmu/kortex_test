from rest_framework.generics import CreateAPIView

from applications.singer.models import Singer
from applications.singer.serializers import SingerSerializer


class SingerAPIView(CreateAPIView):
    queryset = Singer.objects.all()
    serializer_class = SingerSerializer
