::  frontpage for your Urbit
::
::  outer gate is a standard generator
::
|=  [[now=@da eny=@ bek=beak] $~ $~]
::
::  :-  %build
|=  [authorized=? request:http]
^-  mime
:-  ['text' 'html' ~]
%-  as-octs:mimes:html
%-  crip
%-  en-xml:html
^-  manx
;html
  ;head
    ;title:"Ran generator"
  ==
  ;body
    ;h1:"Ran generator"
    ::  ;p:"Executing on {<(scot %p our)>}."
    ;p:"The method was {<(trip method)>}."
    ;p:"The url was {<(trip url)>}."
  ==
==
