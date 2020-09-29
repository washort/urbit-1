++  update
  |=  =update:store
  ^-  (quip card _state)
  |^
  ::  TODO: decide who to send it to based on resource
  ::
  ?>  ?=(%0 -.update)
  :_  state
  ?+  -.q.update       [(poke-store q.update) ~]
      %add-nodes       (add-nodes +.q.update)
      %add-signatures  (add-signatures +.q.update)
  ==
  ::
  ++  add-nodes
    |=  [=resource:store nodes=(map index:store node:store)]
    ^-  (list card)
    :_  ~
    %-  poke-store
    :+  %add-nodes
      resource
    (sign-nodes resource nodes)
  ::
  ++  add-signatures
    |=  [=uid:store =signatures:store]
    ^-  (list card)
    :_  ~
    %-  poke-store
    :+  %add-signatures
      uid
    =*  resource  resource.uid
    =*  index     index.uid
    =*  ship      entity.resource.uid
    =*  name      name.resource.uid
    %-  ~(gas in *signatures:store)
    :_  ~
    -:(sign-node resource (scry-for-node ship name index))
  ::
  ++  sign-nodes
    |=  [=resource:store nodes=(map index:store node:store)]
    ^-  (map index:store node:store)
    %-  ~(run by nodes)
    |=  =node:store
    ^-  node:store
    +:(sign-node resource node)
  ::
  ++  sign-node
    |=  [=resource:store =node:store]
    ^-  [signature:store node:store]
    =*  p  post.node
    =*  ship  entity.resource
    =*  name  name.resource
    =/  parent-hash  (scry-for-parent-hash ship name index.p)
    =/  =validated-portion:store
      [parent-hash author.p index.p time-sent.p contents.p]
    =/  =hash:store  (mug validated-portion)
    =/  =signature:store  (sign:sigs our.bowl now.bowl hash)
    :-  signature
    %_  node
        hash.post  `hash
        signatures.post
      %-  ~(uni in signatures.post.node)
      (~(gas in *signatures:store) [signature]~)
    ==  
  ::
  ++  scry-for-node
    |=  [=ship =term =index:store]
    ^-  node:store
    %+  scry-for:gra  node:store
    %+  weld
      /node/(scot %p ship)/[term]
    (index-to-path index)
  ::
  ++  scry-for-parent-hash
    |=  [=ship =term =index:store]
    ^-  (unit hash:store)
    ?~  index    ~
    ?~  t.index  ~
    =/  lngth=@  (dec (lent index))
    =/  ind=index:store  `(list atom)`(scag lngth `(list atom)`index)
    =/  parent=node:store
      %+  scry-for:gra  node:store
      %+  weld
        /node/(scot %p ship)/[term]
      (index-to-path ind)
    hash.post.parent
  ::
  ++  index-to-path
    |=  =index:store
    ^-  path
    %+  turn  index
    |=  i=atom:store
    (scot %ud i)
  ::
  ++  poke-store
    |=  =update-0:store
    ^-  card
    :*  %pass
        /(scot %da now.bowl)
        %agent
        [our.bowl %graph-store]
        %poke
        [%graph-update !>([%0 now.bowl update-0])]
    ==
  --
