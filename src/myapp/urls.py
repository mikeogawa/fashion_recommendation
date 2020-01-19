from django.urls import path
from . import views

urlpatterns = [
    path('', views.index_template, name='index_template'),
    path("image", views.image_only, name='image_only'),
    path("image/<int:mode>/<int:number>", views.image, name='image'),
    path("image2/<str:number>", views.image2, name='image2'),
    path("nn/<int:number>", views.nn, name='nn'),
]
