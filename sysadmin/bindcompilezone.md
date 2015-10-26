    When you want to check your dns zone transfer is 
	working correctly or not, you can compare files 
	master and slaves file. But transfered files are data
	file you can't read with texteditor. To do that 
	you need to compile from raw to text file 
	as showen in bellow part;

    named-compilezone -f raw -F text -o zone.example.com.txt example.com zone.example.com
