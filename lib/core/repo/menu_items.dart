import 'package:flutter/material.dart';

class MenuItem{
  final String title;
  final IconData icon;
  final String link;

  const MenuItem({
    required this.title,
    required this.icon,
    required this.link,
  });
}

const List<MenuItem> menuItems=[
  MenuItem(
    title: 'Home', 
    icon: Icons.home, 
    link: '/',
    ),
    MenuItem(
    title: 'Solicitudes', 
    icon: Icons.article, 
    link: '/solicitudes',
    ),
  
    MenuItem(
    title: 'Formulario', 
    icon: Icons.format_align_center, 
    link: '/formulario',
    ),
    MenuItem(
    title: 'Historial', 
    icon: Icons.history, 
    link: '/historial',
    ),
    MenuItem(
    title: 'Perfil', 
    icon: Icons.account_circle_rounded, 
    link: '/perfil',
    ),

    MenuItem(
    title: 'LogOut', 
    icon: Icons.logout, 
    link: '/home',
    ),
    

];