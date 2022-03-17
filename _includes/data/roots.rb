{%- comment -%}
*
*  This script is the implementation of Prime Mapping as being described on:
*  https://github.com/chetabahana/chetabahana.github.io/blob/Chetabahana/_layouts/feed.rb
*
*  Get the position of each Id:
*
*  150←149[49][48←43]←148[50][42←37]←147[51][36←30]
*  151←146[52][29←28]←145[53][27←25]←144[54][24←20]
*  152←143[55][19←14]←142[56][13←8]←141[57][7←4]←140[58][3←1]
*  153←[59-63]
*  154←[64-67]
*  155←[68-72]
*  156←157[73][79-83]←158[74][84-88]←159[75][89-96]←160[76][97-99]←161[100-104][]←162[78][105-109]
*  163←[110←114]
*  164←[115←117]
*  165←[118←124]
*  166←[125←129]
*  167←[130←132]
*  168←[133←139]
*
*  Tabulate Prime Hexagon in 18 vs 19.
*
*       |         1st (Form)          |         2nd (Route)         |         3rd (Channel)         |
*  -----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*    1  | 19 |  - | 31 | 37 |  - |  - |  - |  - |  - |  - |  - |  - |  - |  - | 103 |  -  |  - |  - |
*       +----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*    2  | 20 | 26*|  - | 38 |  - |  - |  - |  - |  - | 74*|  - |  - |  - | 98*| 104*|  -  |  - |  - |
*  -----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+ 
*    3  | 21 | 27*|  - | 39 |  - |  - |  - |  - |  - | 75*|  - |  - |  - | 99*| 105*|  -  |  - |  - |
*       +----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*    4  | 22 | 28 |  - | 40 |  - |  - |  - |  - |  - | 76 |  - |  - |  - |100 |  -  |  -  |  - |  - |
*  -----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*    5  | 23 | 29 |  - | 41 |  - |  - |  - |  - |  - | 77 |  - |  - |  - |101 |  -  |  -  |  - |  - | 
*       +----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*    6  | 24 |  - |  - | 42 |  - | 54 |  - |  - | 72 | 78 |  - | 90 | 96 |  - |  -  |  -  |  - | 114|<- 6th row
*  =====+====+====+====+====+====+====+====+====+====+====+====+====+====+====+=====+=====+====+====+
*    7  | 25 |  - |  - | 43 |  - | 55 |  - |  - | 73 | 79 |  - | 91 | 97 |  - |  -  |  -  |  - |  - |
*       +----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*    8  |  - |  - |  - | 44 |  - | 56 |  - |  - |  - | 80 |  - | 92 |  - |  - |  -  |  -  |  - |  - |
*  -----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*    9  |  - |  - |  - | 45 |  - | 57 |  - |  - |  - | 81 |  - | 93 |  - |  - |  -  |  -  |  - |  - |
*       +----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*   10  |  - |  - |  - | 46 | 52 | 58 |  - | 70 |  - | 82 | 88 | 94 |  - |  - |  -  |  -  | 112|  - |
*  -----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*   11  |  - |  - |  - | 47 | 53 | 59 |  - | 71 |  - | 83 | 89 | 95 |  - |  - |  -  |  -  | 113|  - |
*       +----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*   12  |  - |  - |  - | 48 |  - | 60 | 66 |  - |  - | 84 |  - |  - |  - |  - |  -  | 108 |  - |  - | 
*  =====+====+====+====+====+====+====+====+====+====+====+====+====+====+====+=====+=====+====+====+
*   13  |  - |  - |  - | 49 |  - | 61 | 67 |  - |  - | 85 |  - |  - |  - |  - |  -  | 109 |  - |  - | 
*       +----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*   14  |  - |  - | 32*| 50*|  - | 62 | 68*|  - |  - | 86*|  - |  - |  - |  - |  -  | 110*|  - |  - | 
*  -----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*   15  |  - |  - | 33*| 51*|  - | 63 | 69*|  - |  - | 87*|  - |  - |  - |  - |  -  | 111*|  - |  - | 
*       +----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*   16  |  - |  - | 34 |  - |  - | 64 |  - |  - |  - |  - |  - |  - |  - | -  | 106 |  -  |  - |  - | 
*  -----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*   17  |  - |  - | 35 |  - |  - | 65 |  - |  - |  - |  - |  - |  - |  - | -  | 107 |  -  |  - |  - | 
*       +----+----+----+----+----+----+----+----+----+----+----+----+----+----+-----+-----+----+----+
*   18  |  - | 30 | 36 |  - |  - |  - |  - |  - |  - |  - |  - |  - | -  | 102|   - |  -  |  - |  - | <- ∑=168
*  =====+====+====+====+====+====+====+====+====+====+====+====+====+====+====+=====+=====+====+====+
*    1  |  2 |  3 |  4 |  5 |  6 |  7 |  8 |  9 | 10 | 11 | 12 | 13 | 14 | 15 |  16 |  17 | 18 | 19 |
*               Δ    Δ                                                      Δ                     Δ
*              113  150                                                    557                  1000
* Note:
* - The marked number with * are outside of group 18 vs 19 
* - Number 114 located on 6th row vs 19th collumn whereas 114th prime = 619
*
* Cyclic in M+F is happen as followings:
* - The reinjection is exactly goes from 102 to 114-1 or 113
* - The 113 is 30th prime where 30, 36 and 102 are in the 18th row
* - The total of three (3) numbers of 30+36+102 is exactly 168 or π(1000)
* - The 36th prime is reinjected by 151-1 or 150 that carries a delta with 168 of Δ=18
* - The Δ=18 brings the 30th and 36th cycled back to 102th thus consequently to 114th prime
* - The 114th prime is reinjected by 619-1 or 618 to 150+18=168th prime that brings 1000 numbers
* - This scenario will end the 1000 origin numbers become 1000 primes of π(89²) then return to 114 scheme.
*
*  Reference based on prime hexagon:
*
*  https://github.com/chetabahana/hexagon/pull/2
*  https://www.hexspin.com/defining-the-prime-hexagon/
*
{%- endcomment %}
{%- assign my_debug = nil %}
{%- assign my_value = '' | split: ',' %}
{%- case myId %}
    {%- when 9 %}{%- assign my_debug = 100 -%}
    {%- when 13 %}{%- assign my_debug = 110 -%}
    {%- when 17 %}{%- assign my_debug = 101 -%}
    {%- when 68 -%}{%- assign my_debug = 78 -%}
{%- endcase -%}
{%- if my_debug %}{% assign my_pos = my_debug -%}
    {%- elsif myId >= 1 and myId <= 9 %}{%- assign my_debug = 97 | minus: myId -%}
    {%- elsif myId >= 10 and myId <= 28 %}{%- assign my_debug = myId | plus: 38 -%}
    {%- elsif myId >= 29 and myId <= 40 %}{%- assign my_debug = myId | plus: 8 -%}
    {%- elsif myId >= 41 and myId <= 50 %}{%- assign my_debug = myId | plus: 27 -%}
    {%- elsif myId >= 51 and myId <= 68 %}{%- assign my_debug = myId | plus: 72 -%}
    {%- elsif myId >= 69 and myId <= 77 %}{%- assign my_debug = 105 | minus: myId -%}
    {%- elsif myId >= 78 and myId <= 80 %}{%- assign my_debug = myId | minus: 53 -%}
    {%- elsif myId >= 81 and myId <= 85 %}{%- assign my_debug = myId | minus: 61 -%}
    {%- elsif myId >= 86 and myId <= 89 %}{%- assign my_debug = 93 | minus: myId -%}
    {%- elsif myId >= 90 and myId <= 92 %}{%- assign my_debug = myId | plus: 7 -%}
    {%- elsif myId >= 93 and myId <= 98 %}{%- assign my_debug = 106 | minus: myId -%}
    {%- elsif myId >= 99 and myId <= 104 %}{%- assign my_debug = myId | minus: 85 -%}
    {%- elsif myId >= 105 and myId <= 109 %}{%- assign my_debug = 194 | minus: myId -%}
    {%- elsif myId >= 110 and myId <= 114 %}{%- assign my_debug = myId | minus: 31 -%}
    {%- elsif myId >= 115 and myId <= 139 %}{%- assign my_debug = myId | minus: 114 -%}
    {%- elsif myId >= 140 and myId <= 149 %}{%- assign my_debug = myId | plus: 0 -%}
    {%- elsif myId >= 150 and myId <= 168 %}{%- assign my_debug = myId | plus: 0 -%}
{%- endif %}
{%- comment %}
*
*  Get the content
*
*  Get the roots array if the position is one of the 29 frame
*  The sequence is located on the range of 168 minus 29 as below:
*  - seq 1 to 10 will turn to be leading at pos 150 up to 159
*  - seq 11 to 19 will turn to be lagging at pos 168 down to 160
*  - seq 21 to 29 will turn to be lagging at pos 149 down to 140
*  - each of this seq 21 to 29 are attached to the seq of 11 to 19 
*  - thus seq 1 to 10 live as single strand while 11 to 29 as double
*
{%- endcomment %}
{%- if my_debug %}
    {%- assign my_pos = my_debug %}
    {%- assign my_debug = nil %}
    {%- assign values = my_roots[my_pos].val | split: ';' %}
    {%- for value in values %}
        {%- assign my_val = value | times: 1 %}
        {%- assign my_value = my_value | push: my_val %}
    {%- endfor %}
    {%- if my_pos >= 140 and my_pos <= 149 %}{% assign my_fpos = 169 | minus: my_pos %}
    {%- elsif my_pos >= 150 and my_pos <= 159 %}{% assign my_fpos = my_pos | minus: 149 %}
    {%- elsif my_pos >= 160 and my_pos <= 168 %}{% assign my_fpos = 179 | minus: my_pos -%}
    {%- endif %}
{%- else %}
    {%- capture my_debug %}
        {{- content | strip -}}
    {%- endcapture %}
{%- endif %}
{%- comment %}
*
*  Get the roots array
*
*  Reference:
*  https://user-images.githubusercontent.com/36441664/112737922-eda4df80-8f90-11eb-9898-922e5798092a.gif
*  https://user-images.githubusercontent.com/36441664/112738298-390cbd00-8f94-11eb-98aa-f40177769654.png
*  https://user-images.githubusercontent.com/36441664/112737889-9acb2800-8f90-11eb-8b17-4b15a317a717.png
*
{%- endcomment %}
{%- assign n = 0 %}
{%- assign my_keys = '' | split: ',' %}
{%- assign my_rows = '' | split: ',' %}
{%- assign my_node = '' | split: ',' %}
{%- assign my_nodes = '' | split: ',' %}
{%- for item in my_roots limit: my_pos %}
    {%- assign my_root = nil %}
    {%- assign my_frame = nil %}
    {%- assign size = item.pos | size | minus: 2 %}
    {%- assign my_nodes_pos = item.pos | slice: 0, size %}
    {%- comment -%}
    *
    *  Check if the numbers of collected nodes is reaching 10th prime = 29 on the
    *  position of π(1000) - 29 = 168 - 29 = 139. Otherwise assign single node.
    *
    {%- endcomment -%}
    {%- if n <= 139 %}
        {%- unless my_keys contains my_nodes_pos %}
            {%- assign my_rows = my_rows | push: forloop.index0 %}
            {%- assign my_keys = my_keys | push: my_nodes_pos %}
            {%- assign my_nodes = my_nodes | push: my_node %}
            {%- assign my_node = '' | split: ',' %}
        {%- endunless %}
        {%- if n == 139 %}
            {%- assign my_frame = my_nodes[my_fpos] %}
        {%- endif %}
    {%- else %}
        {%- assign my_frame = my_nodes[my_fpos] %}
    {%- endif %}
    {%- if my_frame %}
        {%- assign my_root = nil %}
        {%- break %}
    {%- endif %}
    {%- comment -%}
    *
    *  Take the root value to assign single node
    *
    {%- endcomment -%}
    {%- assign nodes = item.node | split: ';' %}
    {%- for node in nodes %}
        {%- assign n = n | plus: 1 %}
        {%- assign my_obj = node | times: 1 %}
        {%- assign my_node = my_node | push: my_obj %}
        {%- if n != my_pos %}
            {%- continue %}
        {%- else -%}
            {%- assign my_root = node | times: 1 %}
            {%- break %}
        {%- endif %}
    {%- endfor %}
    {%- if my_root %}
        {%- assign my_frame = nil %}
        {%- break %}
    {%- endif %}
{%- endfor -%}
{%- comment -%}
*
*  You may see the running code here:
*  https://chetabahana.github.io/feed.json
*
*  Ref:
*  https://github.com/chetabahana/r12a.github.io
*  https://gist.github.com/magicznyleszek/9803727
*  https://shopify.github.io/liquid/tags/iteration/
*  https://github.com/chetabahana/chetabahana.github.io/releases
*  https://github.com/jekyll/jekyll/issues/5868#issuecomment-278073983
*  https://www.google.com/search?q=how+to+get+element+from+multiple+array+in+jekyll
*  https://community.shopify.com/c/Shopify-Design/Remove-last-2-characters-of-a-string/td-p/236741
*
*  Note:
*  Documentation is currently available in bahasa only
*  https://github.com/chetabahana/chetabahana.github.io/wiki/18
*
{%- endcomment -%}
