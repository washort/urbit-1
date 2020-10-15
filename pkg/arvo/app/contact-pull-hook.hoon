/-  store=contact-store
/+  res=resource, default-agent, dbug, pull-hook
~%  %contact-pull-hook-top  ..is  ~
|%
+$  card  card:agent:gall
++  config
  ^-  config:pull-hook
  :*  %contact-store
      contact-update:store
      %contact-update
      %contact-push-hook
  ==
--
::
%-  agent:dbug
^-  agent:gall
%-  (agent:pull-hook config)
^-  (pull-hook:pull-hook config)
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
    dep   ~(. (default:pull-hook this config) bowl)
::
++  on-init       on-init:def
++  on-save       !>(~)
++  on-load       on-load:def
++  on-poke       on-poke:def
++  on-peek       on-peek:def
++  on-arvo       on-arvo:def
++  on-fail       on-fail:def
++  on-agent      on-agent:def
++  on-watch      on-watch:def
++  on-leave      on-leave:def
++  on-pull-nack
  |=  [=resource:res =tang]
  ^-  (quip card _this)
  :_  this  :_  ~
  :*  %pass
      /pull-nack
      %agent
      [our.bowl %contact-view]
      %poke
      %contact-view-action
      !>([%delete (en-path:res resource)])
  ==
::
++  on-pull-kick
  |=  =resource:res
  ^-  (unit path)
  `/
--
