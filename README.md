# TravelApp_iOS

The app has the following features:

User account login 
• allow users to login by entering the below credentials :
Username and Password
Also, add a Remember me checkbox-  If the user has this checked, they should be automatically logged in and navigated to the Tourist Attraction List screen.
users must be statically added and loaded from a JSON file.

username	password
thanos@gmail.com	1234
wonderwoman@yahoo.com	abc00021
jonsnow@winteriscoming.com	gameofthrones2
superman@kypton.com	kk11iii

Tourist Attractions List:  
o	A list of popular tourist attractions in your city. This list must show the attraction name, address and photo.
o	Tourist attractions must be loaded from a JSON stored in the assets folder.
o	Wishlist - The app should allow users to add a tourist attraction to their “wish list” of things to see. It should be very clear from the UI which attractions are added to the wish list. If the user closes  the app and relaunches the app, your app must remember which attraction was on the wishlist. 

Attraction Details Screen:  
o	When a user selects an attraction from the list, display a screen that shows more detailed information about the attraction. On this page you must show the name, address, phone no, website, more photos , description and pricing. 
o	Ratings  - Users should be able to leave a star rating for the tourist attraction. HINT: Use a “Rating Bar” view
o	Clicking on the phone number will automatically open the phone dialer so the user can attempt to call said place.
o	Clicking on the website would automatically open a web view showing the attraction web page.

General UI Features
o navigation drawer must contain the following:
	Logout  - Clicking this link should logout the user and redirect them back to the Login screen. 
	Tourist Attraction List - This should navigate the user to the Tourist Navigation List
	Map -  For this screen, load a web view that displays a  bing.com map that is centered of your choice.

