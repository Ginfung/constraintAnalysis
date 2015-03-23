function [ f ] = SXFM_web_portal_3obj( x,n )
f = zeros(1,3);
% ------Generated automatically by XMLFeatureModelParser.java-------
% ALL OBJECTIVES ARE SHOULD BE MINIMIZED
%f(1) is total cost
%f(2) is # of rule violations
%f(3) is # of feature NOT provided

global cost;
global usedbefore;
global defects;
global totalFeatureNum;

basic = x(1);
advanced = x(2);
images = x(3);
html = x(4);
dynamic = x(5);
reports = x(6);
popups = x(7);
ban_img = x(8);
ban_flash = x(9);
keyword = x(10);
db = x(11);
file = x(12);
nttp = x(13);
ftp = x(14);
https = x(15);
static = x(16);
asp = x(17);
php = x(18);
jsp = x(19);
cgi = x(20);
xml = x(21);
database = x(22);
data_storage = x(23);
data_transfer = x(24);
user_auth = x(25);
ms = x(26);
sec = x(27);
min = x(28);
logging = db + file == 1; x(29) = logging;
protocol = nttp + ftp + https > 1; x(30) = protocol;
active = asp + php + jsp + cgi > 1; x(31) = active;
persistence = xml + database == 1; x(32) = persistence;
ri = data_storage + data_transfer + user_auth > 1; x(33) = ri;
performance = ms + sec + min == 1; x(34) = performance;
cont = static;  x(35) = cont;
web_server = cont;  x(36) = web_server;
banners = ban_img;  x(37) = banners;
ad_server = reports & banners;  x(38) = ad_server;
text = html;  x(39) = text;
site_search = images | text;  x(40) = site_search;
site_stats = basic;  x(41) = site_stats;
add_services = site_stats | site_search | ad_server;  x(42) = add_services;
web_portal = web_server;  x(43) = web_portal;


C4= (~data_transfer) | https;
C3= (~db) | database;
C6= (~https) |(~ms);
C5= (~file) | ftp;
C1= (~keyword) | text;
C2= (~dynamic) | active;


%f(1) is total cost
f(1) = sum(cost.*x);
%f(2) is # of rule violations
f(2) = 6 - (C1+C2+C3+C4+C5+C6);
%f(3) is # of feature NOT provided
f(3) = totalFeatureNum - sum(x);
end

