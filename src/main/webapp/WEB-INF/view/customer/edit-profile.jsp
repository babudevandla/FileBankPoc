<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
	
<head>
		   <!-- Stylesheets
 ================================================= -->
<link rel="stylesheet" href="${contextPath}/resources/default/css/bootstrap.min.css" />
<link rel="stylesheet" href="${contextPath}/resources/default/css/style.css" />
<link rel="stylesheet" href="${contextPath}/resources/default/css/ionicons.min.css" />
<link rel="stylesheet" href="${contextPath}/resources/default/css/font-awesome.min.css" />

<!--Google Font-->
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,700i" rel="stylesheet">

<!--Favicon-->
<link rel="shortcut icon" type="image/png" href="${contextPath}/resources/default/images/fav.png"/>
	</head>
  <body>

    <!-- Header
    ================================================= -->
		<header id="header">
      <nav class="navbar navbar-default navbar-fixed-top menu">
        <div class="container">

          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${contextPath}/sm/dashboard"><strong style="color: white;"> 
            	<img src="${contextPath}/resources/default/images/sm_logo.png" alt="Folder" style="width: 60px;"> </strong>
            </a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right main-menu">
              <li class="dropdown"><a href="${contextPath}/sm/profile"><i class="icon ion-person"></i>&nbsp; Profile</a></li>
              <li class="dropdown"><a href="<c:url value="/j_spring_security_logout" />" class="btn"> <i class="icon ion-log-out"></i>&nbsp; Logout</a></li>
            </ul>
            
          </div><!-- /.navbar-collapse -->
        </div><!-- /.container -->
      </nav>
    </header>
    <!--Header End-->

    <div class="container">

      <!-- Timeline
      ================================================= -->
      <div class="timeline">
        <div class="timeline-cover">

          <!--Timeline Menu for Large Screens-->
          <div class="timeline-nav-bar hidden-sm hidden-xs">
            <div class="row">
              <div class="col-md-3">
                <div class="profile-info">
                  <img src="${contextPath}/resources/default/images/avatar.png" alt="" class="img-responsive profile-photo" />
                  <h3>${user.firstname}&nbsp;${user.lastname}</h3>
                  <p class="text-muted">Creative Director</p>
                </div>
              </div>
              <div class="col-md-9">
                <ul class="list-inline profile-menu">
                  <li><a href="timeline.html">Timeline</a></li>
                  <li><a href="timeline-about.html" class="active">About</a></li>
                  <li><a href="timeline-album.html">Album</a></li>
                  <li><a href="timeline-friends.html">Friends</a></li>
                </ul>
              </div>
            </div>
          </div><!--Timeline Menu for Large Screens End-->

          <!--Timeline Menu for Small Screens-->
          <div class="navbar-mobile hidden-lg hidden-md">
            <div class="profile-info">
              <img src="${contextPath}/resources/default/images/avatar.png" alt="" class="img-responsive profile-photo" />
              <h4>${user.firstname}&nbsp;${user.lastname}</h4>
              <p class="text-muted">Creative Director</p>
            </div>
            <div class="mobile-menu">
              <ul class="list-inline">
                <li><a href="timline.html">Timeline</a></li>
                <li><a href="timeline-about.html" class="active">About</a></li>
                <li><a href="timeline-album.html">Album</a></li>
                <li><a href="timeline-friends.html">Friends</a></li>
              </ul>
              <button class="btn-primary">Add Friend</button>
            </div>
          </div><!--Timeline Menu for Small Screens End-->

        </div>
        <div id="page-contents">
          <div class="row">
            <div class="col-md-3">
              
              <!--Edit Profile Menu-->
              <ul class="edit-menu">
              	<li class="active"><i class="icon ion-ios-information-outline"></i><a href="edit-profile-basic.html">Basic Information</a></li>
              	<li><i class="icon ion-ios-briefcase-outline"></i><a href="edit-profile-work-edu.html">Education and Work</a></li>
              	<li><i class="icon ion-ios-heart-outline"></i><a href="edit-profile-interests.html">My Interests</a></li>
                <li><i class="icon ion-ios-settings"></i><a href="edit-profile-settings.html">Account Settings</a></li>
              	<li><i class="icon ion-ios-locked-outline"></i><a href="edit-profile-password.html">Change Password</a></li>
              </ul>
            </div>
            <div class="col-md-7">

              <!-- Basic Information
              ================================================= -->
              <div class="edit-profile-container">
                <div class="block-title">
                  <h4 class="grey"><i class="icon ion-android-checkmark-circle"></i>Edit basic information</h4>
                  <div class="line"></div>
                  <p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate</p>
                  <div class="line"></div>
                </div>
                <div class="edit-block">
                  <form  action="${contextPath}/sm/user_basic_info" method="post" id="basic-info" class="form-inline">
                  <input type="hidden" id="userId" name="userId" value="${user.userId}">
                    <div class="row">
                      <div class="form-group col-xs-6">
                        <label for="firstname">First name</label>
                        <input id="firstname" class="form-control input-group-lg" type="text" name="firstname" title="Enter first name" placeholder="First name" value="${user.firstname}" />
                      </div>
                      <div class="form-group col-xs-6">
                        <label for="lastname" class="">Last name</label>
                        <input id="lastname" class="form-control input-group-lg" type="text" name="lastname" title="Enter last name" placeholder="Last name" value="${user.lastname}" />
                      </div>
                    </div>
                    <div class="row">
                      <div class="form-group col-xs-12">
                        <label for="email">My email</label>
                        <input id="email" class="form-control input-group-lg" type="text" name="email" title="Enter Email" placeholder="My Email" value="${user.email}" />
                      </div>
                    </div>
                    <div class="row">
                      <p class="custom-label"><strong>Date of Birth</strong></p>
                      <div class="form-group col-sm-3 col-xs-6">
                        <label for="month" class="sr-only"></label>
                        <select class="form-control" name="birthday_date" id="day">
                          <option value="Day">Day</option>
                         <% for(int i=1;i<=31;i++) { %>	
                          <option value="<%=i%>"><%=i%></option>
                          <% }%>
                        </select>
                      </div>
                      <div class="form-group col-sm-3 col-xs-6">
                        <label for="month" class="sr-only"></label>
                        <select class="form-control" name="birthday_month" id="month">
                          <option value="">Month</option>
                          <option value="Jan">Jan</option>
                          <option value="Feb">Feb</option>
                          <option value="Mar">Mar</option>
                          <option value="Apr">Apr</option>
                          <option value="May">May</option>
                          <option value="Jun">Jun</option>
                          <option value="Jul">Jul</option>
                          <option value="Aug">Aug</option>
                          <option value="Sep">Sep</option>
                          <option value="Oct">Oct</option>
                          <option value="Nov">Nov</option>
                          <option value="Dec">Dec</option>
                        </select>
                      </div>
                      <div class="form-group col-sm-6 col-xs-12">
                        <label for="year" class="sr-only"></label>
                        <select class="form-control" name="birthday_year" id="year">
                          <option value="year">Year</option>
                           <% for(int i=1900;i<=2017;i++) { %>	
                          <option value="<%=i%>"><%=i%></option>
                          <% }%>
                        </select>
                      </div>
                    </div>
                    <div class="form-group gender">
                      <span class="custom-label"><strong>I am a: </strong></span>
                      <label class="radio-inline">
                        <input type="radio" name="gender" value="M" >Male
                      </label>
                      <label class="radio-inline">
                        <input type="radio" name="gender" value="F" >Female
                      </label>
                    </div>
                    <div class="row">
                      <div class="form-group col-xs-6">
                        <label for="city"> My city</label>
                        <input id="city" class="form-control input-group-lg" type="text" name="city" title="Enter city" placeholder="Your city" value="${user.city}"/>
                      </div>
                      <div class="form-group col-xs-6">
                        <label for="country">My country</label>
                        <select class="form-control" name="country" id="country">
                          <option value="country">Country</option>
                          <option value="AFG">Afghanistan</option>
                          <option value="ALA">Ƭand Islands</option>
                          <option value="ALB">Albania</option>
                          <option value="DZA">Algeria</option>
                          <option value="ASM">American Samoa</option>
                          <option value="AND">Andorra</option>
                          <option value="AGO">Angola</option>
                          <option value="AIA">Anguilla</option>
                          <option value="ATA">Antarctica</option>
                          <option value="ATG">Antigua and Barbuda</option>
                          <option value="ARG">Argentina</option>
                          <option value="ARM">Armenia</option>
                          <option value="ABW">Aruba</option>
                          <option value="AUS">Australia</option>
                          <option value="AUT">Austria</option>
                          <option value="AZE">Azerbaijan</option>
                          <option value="BHS">Bahamas</option>
                          <option value="BHR">Bahrain</option>
                          <option value="BGD">Bangladesh</option>
                          <option value="BRB">Barbados</option>
                          <option value="BLR">Belarus</option>
                          <option value="BEL">Belgium</option>
                          <option value="BLZ">Belize</option>
                          <option value="BEN">Benin</option>
                          <option value="BMU">Bermuda</option>
                          <option value="BTN">Bhutan</option>
                          <option value="BOL">Bolivia, Plurinational State of</option>
                          <option value="BES">Bonaire, Sint Eustatius and Saba</option>
                          <option value="BIH">Bosnia and Herzegovina</option>
                          <option value="BWA">Botswana</option>
                          <option value="BVT">Bouvet Island</option>
                          <option value="BRA">Brazil</option>
                          <option value="IOT">British Indian Ocean Territory</option>
                          <option value="BRN">Brunei Darussalam</option>
                          <option value="BGR">Bulgaria</option>
                          <option value="BFA">Burkina Faso</option>
                          <option value="BDI">Burundi</option>
                          <option value="KHM">Cambodia</option>
                          <option value="CMR">Cameroon</option>
                          <option value="CAN">Canada</option>
                          <option value="CPV">Cape Verde</option>
                          <option value="CYM">Cayman Islands</option>
                          <option value="CAF">Central African Republic</option>
                          <option value="TCD">Chad</option>
                          <option value="CHL">Chile</option>
                          <option value="CHN">China</option>
                          <option value="CXR">Christmas Island</option>
                          <option value="CCK">Cocos (Keeling) Islands</option>
                          <option value="COL">Colombia</option>
                          <option value="COM">Comoros</option>
                          <option value="COG">Congo</option>
                          <option value="COD">Congo, the Democratic Republic of the</option>
                          <option value="COK">Cook Islands</option>
                          <option value="CRI">Costa Rica</option>
                          <option value="CIV">C𴥠d'Ivoire</option>
                          <option value="HRV">Croatia</option>
                          <option value="CUB">Cuba</option>
                          <option value="CUW">Cura袯</option>
                          <option value="CYP">Cyprus</option>
                          <option value="CZE">Czech Republic</option>
                          <option value="DNK">Denmark</option>
                          <option value="DJI">Djibouti</option>
                          <option value="DMA">Dominica</option>
                          <option value="DOM">Dominican Republic</option>
                          <option value="ECU">Ecuador</option>
                          <option value="EGY">Egypt</option>
                          <option value="SLV">El Salvador</option>
                          <option value="GNQ">Equatorial Guinea</option>
                          <option value="ERI">Eritrea</option>
                          <option value="EST">Estonia</option>
                          <option value="ETH">Ethiopia</option>
                          <option value="FLK">Falkland Islands (Malvinas)</option>
                          <option value="FRO">Faroe Islands</option>
                          <option value="FJI">Fiji</option>
                          <option value="FIN">Finland</option>
                          <option value="FRA">France</option>
                          <option value="GUF">French Guiana</option>
                          <option value="PYF">French Polynesia</option>
                          <option value="ATF">French Southern Territories</option>
                          <option value="GAB">Gabon</option>
                          <option value="GMB">Gambia</option>
                          <option value="GEO">Georgia</option>
                          <option value="DEU">Germany</option>
                          <option value="GHA">Ghana</option>
                          <option value="GIB">Gibraltar</option>
                          <option value="GRC">Greece</option>
                          <option value="GRL">Greenland</option>
                          <option value="GRD">Grenada</option>
                          <option value="GLP">Guadeloupe</option>
                          <option value="GUM">Guam</option>
                          <option value="GTM">Guatemala</option>
                          <option value="GGY">Guernsey</option>
                          <option value="GIN">Guinea</option>
                          <option value="GNB">Guinea-Bissau</option>
                          <option value="GUY">Guyana</option>
                          <option value="HTI">Haiti</option>
                          <option value="HMD">Heard Island and McDonald Islands</option>
                          <option value="VAT">Holy See (Vatican City State)</option>
                          <option value="HND">Honduras</option>
                          <option value="HKG">Hong Kong</option>
                          <option value="HUN">Hungary</option>
                          <option value="ISL">Iceland</option>
                          <option value="IND">India</option>
                          <option value="IDN">Indonesia</option>
                          <option value="IRN">Iran, Islamic Republic of</option>
                          <option value="IRQ">Iraq</option>
                          <option value="IRL">Ireland</option>
                          <option value="IMN">Isle of Man</option>
                          <option value="ISR">Israel</option>
                          <option value="ITA">Italy</option>
                          <option value="JAM">Jamaica</option>
                          <option value="JPN">Japan</option>
                          <option value="JEY">Jersey</option>
                          <option value="JOR">Jordan</option>
                          <option value="KAZ">Kazakhstan</option>
                          <option value="KEN">Kenya</option>
                          <option value="KIR">Kiribati</option>
                          <option value="PRK">Korea, Democratic People's Republic of</option>
                          <option value="KOR">Korea, Republic of</option>
                          <option value="KWT">Kuwait</option>
                          <option value="KGZ">Kyrgyzstan</option>
                          <option value="LAO">Lao People's Democratic Republic</option>
                          <option value="LVA">Latvia</option>
                          <option value="LBN">Lebanon</option>
                          <option value="LSO">Lesotho</option>
                          <option value="LBR">Liberia</option>
                          <option value="LBY">Libya</option>
                          <option value="LIE">Liechtenstein</option>
                          <option value="LTU">Lithuania</option>
                          <option value="LUX">Luxembourg</option>
                          <option value="MAC">Macao</option>
                          <option value="MKD">Macedonia, the former Yugoslav Republic of</option>
                          <option value="MDG">Madagascar</option>
                          <option value="MWI">Malawi</option>
                          <option value="MYS">Malaysia</option>
                          <option value="MDV">Maldives</option>
                          <option value="MLI">Mali</option>
                          <option value="MLT">Malta</option>
                          <option value="MHL">Marshall Islands</option>
                          <option value="MTQ">Martinique</option>
                          <option value="MRT">Mauritania</option>
                          <option value="MUS">Mauritius</option>
                          <option value="MYT">Mayotte</option>
                          <option value="MEX">Mexico</option>
                          <option value="FSM">Micronesia, Federated States of</option>
                          <option value="MDA">Moldova, Republic of</option>
                          <option value="MCO">Monaco</option>
                          <option value="MNG">Mongolia</option>
                          <option value="MNE">Montenegro</option>
                          <option value="MSR">Montserrat</option>
                          <option value="MAR">Morocco</option>
                          <option value="MOZ">Mozambique</option>
                          <option value="MMR">Myanmar</option>
                          <option value="NAM">Namibia</option>
                          <option value="NRU">Nauru</option>
                          <option value="NPL">Nepal</option>
                          <option value="NLD">Netherlands</option>
                          <option value="NCL">New Caledonia</option>
                          <option value="NZL">New Zealand</option>
                          <option value="NIC">Nicaragua</option>
                          <option value="NER">Niger</option>
                          <option value="NGA">Nigeria</option>
                          <option value="NIU">Niue</option>
                          <option value="NFK">Norfolk Island</option>
                          <option value="MNP">Northern Mariana Islands</option>
                          <option value="NOR">Norway</option>
                          <option value="OMN">Oman</option>
                          <option value="PAK">Pakistan</option>
                          <option value="PLW">Palau</option>
                          <option value="PSE">Palestinian Territory, Occupied</option>
                          <option value="PAN">Panama</option>
                          <option value="PNG">Papua New Guinea</option>
                          <option value="PRY">Paraguay</option>
                          <option value="PER">Peru</option>
                          <option value="PHL">Philippines</option>
                          <option value="PCN">Pitcairn</option>
                          <option value="POL">Poland</option>
                          <option value="PRT">Portugal</option>
                          <option value="PRI">Puerto Rico</option>
                          <option value="QAT">Qatar</option>
                          <option value="REU">R궮ion</option>
                          <option value="ROU">Romania</option>
                          <option value="RUS">Russian Federation</option>
                          <option value="RWA">Rwanda</option>
                          <option value="BLM">Saint Barthꭥmy</option>
                          <option value="SHN">Saint Helena, Ascension and Tristan da Cunha</option>
                          <option value="KNA">Saint Kitts and Nevis</option>
                          <option value="LCA">Saint Lucia</option>
                          <option value="MAF">Saint Martin (French part)</option>
                          <option value="SPM">Saint Pierre and Miquelon</option>
                          <option value="VCT">Saint Vincent and the Grenadines</option>
                          <option value="WSM">Samoa</option>
                          <option value="SMR">San Marino</option>
                          <option value="STP">Sao Tome and Principe</option>
                          <option value="SAU">Saudi Arabia</option>
                          <option value="SEN">Senegal</option>
                          <option value="SRB">Serbia</option>
                          <option value="SYC">Seychelles</option>
                          <option value="SLE">Sierra Leone</option>
                          <option value="SGP">Singapore</option>
                          <option value="SXM">Sint Maarten (Dutch part)</option>
                          <option value="SVK">Slovakia</option>
                          <option value="SVN">Slovenia</option>
                          <option value="SLB">Solomon Islands</option>
                          <option value="SOM">Somalia</option>
                          <option value="ZAF">South Africa</option>
                          <option value="SGS">South Georgia and the South Sandwich Islands</option>
                          <option value="SSD">South Sudan</option>
                          <option value="ESP">Spain</option>
                          <option value="LKA">Sri Lanka</option>
                          <option value="SDN">Sudan</option>
                          <option value="SUR">Suriname</option>
                          <option value="SJM">Svalbard and Jan Mayen</option>
                          <option value="SWZ">Swaziland</option>
                          <option value="SWE">Sweden</option>
                          <option value="CHE">Switzerland</option>
                          <option value="SYR">Syrian Arab Republic</option>
                          <option value="TWN">Taiwan, Province of China</option>
                          <option value="TJK">Tajikistan</option>
                          <option value="TZA">Tanzania, United Republic of</option>
                          <option value="THA">Thailand</option>
                          <option value="TLS">Timor-Leste</option>
                          <option value="TGO">Togo</option>
                          <option value="TKL">Tokelau</option>
                          <option value="TON">Tonga</option>
                          <option value="TTO">Trinidad and Tobago</option>
                          <option value="TUN">Tunisia</option>
                          <option value="TUR">Turkey</option>
                          <option value="TKM">Turkmenistan</option>
                          <option value="TCA">Turks and Caicos Islands</option>
                          <option value="TUV">Tuvalu</option>
                          <option value="UGA">Uganda</option>
                          <option value="UKR">Ukraine</option>
                          <option value="ARE">United Arab Emirates</option>
                          <option value="GBR">United Kingdom</option>
                          <option value="USA" selected>United States</option>
                          <option value="UMI">United States Minor Outlying Islands</option>
                          <option value="URY">Uruguay</option>
                          <option value="UZB">Uzbekistan</option>
                          <option value="VUT">Vanuatu</option>
                          <option value="VEN">Venezuela, Bolivarian Republic of</option>
                          <option value="VNM">Viet Nam</option>
                          <option value="VGB">Virgin Islands, British</option>
                          <option value="VIR">Virgin Islands, U.S.</option>
                          <option value="WLF">Wallis and Futuna</option>
                          <option value="ESH">Western Sahara</option>
                          <option value="YEM">Yemen</option>
                          <option value="ZMB">Zambia</option>
                          <option value="ZWE">Zimbabwe</option>
                        </select>
                      </div>
                    </div>
                    <div class="row">
                      <div class="form-group col-xs-12">
                        <label for="my-info">About me</label>
                        <textarea id="my-info" name="about" class="form-control" placeholder="Some texts about me" rows="4" cols="400"></textarea>
                      </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                  </form>
                </div>
              </div>
            </div>
            
          </div>
        </div>
      </div>
    </div>


    <!-- Footer
    ================================================= -->
   <footer id="footer">
      <div class="container">
      	<div class="row">
          <%-- <div class="footer-wrapper">
            <div class="col-md-3 col-sm-3" >
              <a href="#" style="font-size: 30px;" > SM Portal</a>
              <ul class="list-inline social-icons">
              	<li><a href="#"><i class="icon ion-social-facebook"></i></a></li>
              	<li><a href="#"><i class="icon ion-social-twitter"></i></a></li>
              	<li><a href="#"><i class="icon ion-social-googleplus"></i></a></li>
              	<li><a href="#"><i class="icon ion-social-pinterest"></i></a></li>
              	<li><a href="#"><i class="icon ion-social-linkedin"></i></a></li>
              </ul>
            </div> 
            <div class="col-md-2 col-sm-2">
              <h5>For individuals</h5>
              <ul class="footer-links">
                <li><a href="${contextPath}/signup">Signup</a></li>
                <li><a href="${contextPath}/login">login</a></li>
              </ul>
            </div>
             <div class="col-md-2 col-sm-2">
              <h5>For businesses</h5>
              <ul class="footer-links">
                <li><a href="#">Business signup</a></li>
                <li><a href="#">Business login</a></li>
                <li><a href="#">Benefits</a></li>
                <li><a href="#">Resources</a></li>
                <li><a href="#">Advertise</a></li>
                <li><a href="#">Setup</a></li>
              </ul>
            </div>
            <div class="col-md-2 col-sm-2">
              <h5>About</h5>
              <ul class="footer-links">
                <li><a href="#">About us</a></li>
                <li><a href="#">Contact us</a></li>
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Terms</a></li>
                <li><a href="#">Help</a></li>
              </ul>
            </div>
             <div class="col-md-3 col-sm-3">
              <h5>Contact Us</h5>
              <ul class="contact">
                <li><i class="icon ion-ios-telephone-outline"></i>+1 (234) 222 0754</li>
                <li><i class="icon ion-ios-email-outline"></i>info@thunder-team.com</li>
                <li><i class="icon ion-ios-location-outline"></i>228 Park Ave S NY, USA</li>
              </ul>
            </div> 
          </div> --%>
      	</div>
      </div>
      <div class="copyright">
        <p>SM Team � 2018. All rights reserved</p>
      </div>
		</footer>
    
    <!--preloader-->
    <div id="spinner-wrapper">
      <div class="spinner"></div>
    </div>
  
    <!-- Scripts
    ================================================= -->
     <script src="${contextPath}/resources/default/js/jquery-3.1.1.min.js"></script>
    <script src="${contextPath}/resources/default/js/bootstrap.min.js"></script>
    <script src="${contextPath}/resources/default/js/jquery.appear.min.js"></script>
	<script src="${contextPath}/resources/default/js/jquery.incremental-counter.js"></script>
    <script src="${contextPath}/resources/default/js/script.js"></script>
    
  </body>

</html>
