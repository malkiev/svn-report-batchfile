set yy=%date:~-4%
set mm=%date:~-7,2%
set dd=%date:~-10,2%
set MYDATE=%yy%%mm%%dd%
set FROMDATE= {2016-02-01}
set TODATE= {2016-02-04}

@echo Contacts > c:\holistic\svnlog.txt
svn log -l 10 https://defiant.holistic.local/svn/Wisdom5/trunk/Contacts -r {2016-02-01}:{2016-02-04} >> c:\holistic\svnlog.txt
@echo Documents >> c:\holistic\svnlog.txt
svn log -l 10 https://defiant.holistic.local/svn/Wisdom5/trunk/Documents -r {2016-02-01}:{2016-02-04} >> c:\holistic\svnlog.txt
@echo Core >> c:\holistic\svnlog.txt
svn log -l 10 https://defiant.holistic.local/svn/Wisdom5/trunk/Core -r {2016-02-01}:{2016-02-04} >> c:\holistic\svnlog.txt
@echo Data >> c:\holistic\svnlog.txt
svn log -l 10 https://defiant.holistic.local/svn/Wisdom5/trunk/w5_data -r {2016-02-01}:{2016-02-04} >> c:\holistic\svnlog.txt
@echo Stock >> c:\holistic\svnlog.txt
svn log -l 10 https://defiant.holistic.local/svn/Wisdom5/trunk/Stock -r {2016-02-01}:{2016-02-04} >> c:\holistic\svnlog.txt
@echo Payments >> c:\holistic\svnlog.txt
svn log -l 10 https://defiant.holistic.local/svn/Wisdom5/trunk/Payments -r {2016-02-01}:{2016-02-04} >> c:\holistic\svnlog.txt

