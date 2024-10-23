part of 'template.bloc.dart';

sealed class TemplateEvent {
  const TemplateEvent();
}

class Inititalize extends TemplateEvent {
  const Inititalize();
}
