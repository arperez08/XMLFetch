XMLFetch
========

The application read the XML data from the URL https://dl.dropboxusercontent.com/u/101222705/business.xml
It get the data using NSURLConnection:
 - define URL
 - Create NSMutableRequest
 - Create URL Connection
 
 Parse the XML data using GDataXMLNode. Get the data of every elements and link the data to UILabel.
 I also used the MapKit to get the location of the given longitude and latitude. 
 Also used MapAnnotation to give label on the current location.
