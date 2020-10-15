/+  res=resource
/+  group
/+  default-agent
/+  dbug
/+  push-hook
~%  %contact-push-hook-top  ..is  ~
|%
+$  card  card:agent:gall
++  config
  ^-  config:push-hook
  :*  %graph-store
      /updates
      update:store
      %graph-update
      %graph-pull-hook
  ==
::
+$  agent  (push-hook:push-hook config)
::
++  is-allowed
  |=  [=resource:res =bowl:gall =ship requires-admin=?]
  ^-  ?
  =/  grp  ~(. group bowl)
  ?:  requires-admin
    (is-admin:grp src.bowl (en-path:res resource))
  ?|  ?&  =(src.bowl ship)
          (is-member:grp src.bowl (en-path:res resource))
      ==
      (is-admin:grp src.bowl (en-path:res resource))
  ==
--
::
%-  agent:dbug
^-  agent:gall
%-  (agent:push-hook config)
^-  agent
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
    grp   ~(. group bowl)
    gra   ~(. graph bowl)
::
++  on-init   on-init:def
++  on-save   !>(~)
++  on-load   on-load:def
++  on-poke   on-poke:def
++  on-agent  on-agent:def
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
::
++  should-proxy-update
  |=  =vase
  ^-  ?
  =/  upd=contact-update:store  !<(contact-update:store vase)
  ?-  -.upd
      %create    %.n
      %delete    (is-allowed (en-path:res path.upd) bowl *ship %.y)
      %add       (is-allowed (en-path:res path.upd) bowl ship.upd %.n)
      %remove    (is-allowed (en-path:res path.upd) bowl ship.upd %.n)
      %edit      (is-allowed (en-path:res path.upd) bowl ship.upd %.n)
      %initial   %.n
      %contacts  (is-allowed (en-path:res path.upd) bowl *ship %.y)
  ==
::
++  resource-for-update
  |=  =vase
  ^-  (unit resource:res)
  =/  upd=contact-update:store  !<(contact-update:store vase)
  ?-  -.upd
      %create    ~
      %delete    `(en-path:res path.upd)
      %add       `(en-path:res path.upd)
      %remove    `(en-path:res path.upd)
      %edit      `(en-path:res path.upd)
      %initial   ~
      %contacts  `(en-path:res path.upd)
  ==
::
++  initial-watch
  |=  [=path =resource:res]
  ^-  vase
  ?>  (is-allowed resource bowl %.n)
  !>  ^-  contact-update:store
  ::  new subscribe
  ::
  [%contacts (en-path:res resource) (get-contacts:con resource)]
::
++  take-update
  |=  =vase
  ^-  [(list card) agent]
  =/  upd=contact-update:store  !<(contact-update:store vase)
  ?+  -.upd    [~ this]
      %delete  [[%give %kick ~[path.upd] ~]~ this]
  ==
--
