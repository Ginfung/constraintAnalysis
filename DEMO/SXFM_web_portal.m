function [ f ] = SXFM_web_portal( x,n )
f = zeros(1,5);
% ALL OBJECTIVES ARE SHOULD BE MINIMIZED
%f(1) is total cost
%f(2) is feature that were NOT used before
%f(3) is total number of known defects
%f(4) is # of rule violations
%f(5) is # of feature NOT provided

basic=x(1);
advanced=x(2);
images=x(3);
html=x(4);
dynamic=x(5);
reports=x(6);
popups=x(7);
ban_img=x(8);
ban_flash=x(9);
keyword=x(10);
db=x(11);
file=x(12);
nttp=x(13);
ftp=x(14);
https=x(15);
static=x(16);
asp=x(17);
php=x(18);
jsp=x(19);
cgi=x(20);
xml=x(21);
database=x(22);
data_storage=x(23);
data_transfer=x(24);
user_auth=x(25);
ms=x(26);
sec=x(27);
min=x(28);
logging = db + file == 1;
protocol = nttp + ftp + https > 1;
active = asp + php + jsp + cgi > 1;
persistence = xml + database == 1;
ri = data_storage + data_transfer + user_auth > 1;
performance = ms + sec + min == 1;

cont = static
text = html
web_server = cont
web_portal = web_server
banners = ban_img
site_stats = basic
site_search = images | text
ad_server = reports & banners
add_services = site_stats | site_search | ad_server

end

