from rest_framework.generics import ListCreateAPIView, ListAPIView, RetrieveAPIView
from rest_framework.permissions import IsAuthenticated, AllowAny
from news.models import News
from news.serializers import NewsSerializer


class NewsListView(ListAPIView):
    permission_classes = [AllowAny]
    serializer_class = NewsSerializer
    queryset = News.objects.all()


class NewsDetailView(RetrieveAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = NewsSerializer
    queryset = News.objects.all()
    lookup_field = 'pk'

