<%@ page pageEncoding="ISO-8859-1"  contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@taglib prefix="defaultTemplate" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html lang="en">
	
<head>
	<link rel="stylesheet" href="${contextPath}/resources/default/css/bootstrap.min.css" />
	<link rel="stylesheet" href="${contextPath}/resources/default/css/style.css" />
	<link rel="stylesheet" href="${contextPath}/resources/default/css/ionicons.min.css" />
    <link rel="stylesheet" href="${contextPath}/resources/default/css/font-awesome.min.css" />
    <link rel="stylesheet" href="${contextPath}/resources/engine1/style.css" />
   <!--Google Font-->
   <link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,700i" rel="stylesheet">
   
   <!--Favicon-->
   <link rel="shortcut icon" type="image/png" href="${contextPath}/resources/default/images/fav.png"/>
</head>
<body>

    <!-- Header
    ================================================= -->
		<header id="header-inverse">
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
            <a class="navbar-brand" href="${contextPath}/"><strong style="color: white;"> 
            	<img src="${contextPath}/resources/default/images/sm_logo.png" alt="Folder" style="width: 60px;"> </strong>
            </a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right main-menu">
             <%--  <li class="dropdown">
               <a href="${contextPath}/login" >Login </a>
             </li> --%>
              <li class="dropdown"><a href="${contextPath}/contact">Contact</a></li>
            </ul>
            
          </div>
        </div>
      </nav>
    </header>
    <!--Header End-->
    
    <!-- Landing Page Contents
    ================================================= -->
    <div id="lp-register">
    	<div class="container wrapper">
        <div class="row">
        	<div class="col-sm-5">
              <!-- Start WOWSlider.com BODY section -->
					<div id="wowslider-container1">
					<div class="ws_images"><ul>
							<li><img src="${contextPath}/resources/data1/images/digilocker.jpg" alt="digilocker" title="digilocker" id="wows1_0"/></li>
							<li><img src="${contextPath}/resources/data1/images/digilocker_flow.png" alt="digilocker_flow" title="digilocker_flow" id="wows1_1"/></li>
							<li><img src="${contextPath}/resources/data1/images/my_personal_diary.jpg" alt="my_personal_diary" title="my_personal_diary" id="wows1_2"/></li>
							<li><img src="${contextPath}/resources/data1/images/my_edairys.jpg" alt="my_edairys" title="my_edairys" id="wows1_3"/></li>
							<li><img src="${contextPath}/resources/data1/images/diaries_writting.jpg" alt="diaries_writting" title="diaries_writting" id="wows1_4"/></li>
							<li><img src="${contextPath}/resources/data1/images/ebooks_library.jpg" alt="Ebooks_library" title="Ebooks_library" id="wows1_5"/></li>
							<li><img src="${contextPath}/resources/data1/images/books_sections.jpg" alt="books_sections" title="books_sections" id="wows1_6"/></li>
							<li><img src="${contextPath}/resources/data1/images/book.jpg" alt="book" title="book" id="wows1_7"/></li>
							<li><img src="${contextPath}/resources/data1/images/ebooks_standards.png" alt="ebooks_standards" title="ebooks_standards" id="wows1_8"/></li>
							<li><img src="${contextPath}/resources/data1/images/pa_flow.jpg" alt="PA_flow" title="PA_flow" id="wows1_9"/></li>
							<li><a href="http://wowslider.net"><img src="${contextPath}/resources/data1/images/pa_helps.jpg" alt="html slider" title="PA_helps" id="wows1_10"/></a></li>
							<li><img src="${contextPath}/resources/data1/images/oneassistantallneeds.jpg" alt="oneassistantallneeds" title="oneassistantallneeds" id="wows1_11"/></li>
						</ul></div>
						<div class="ws_bullets"><div>
							<a href="#" title="digilocker"><span><img src="${contextPath}/resources/data1/tooltips/digilocker.jpg" alt="digilocker"/>1</span></a>
							<a href="#" title="digilocker_flow"><span><img src="${contextPath}/resources/data1/tooltips/digilocker_flow.png" alt="digilocker_flow"/>2</span></a>
							<a href="#" title="my_personal_diary"><span><img src="${contextPath}/resources/data1/tooltips/my_personal_diary.jpg" alt="my_personal_diary"/>3</span></a>
							<a href="#" title="my_edairys"><span><img src="${contextPath}/resources/data1/tooltips/my_edairys.jpg" alt="my_edairys"/>4</span></a>
							<a href="#" title="diaries_writting"><span><img src="${contextPath}/resources/data1/tooltips/diaries_writting.jpg" alt="diaries_writting"/>5</span></a>
							<a href="#" title="Ebooks_library"><span><img src="${contextPath}/resources/data1/tooltips/ebooks_library.jpg" alt="Ebooks_library"/>6</span></a>
							<a href="#" title="books_sections"><span><img src="${contextPath}/resources/data1/tooltips/books_sections.jpg" alt="books_sections"/>7</span></a>
							<a href="#" title="book"><span><img src="${contextPath}/resources/data1/tooltips/book.jpg" alt="book"/>8</span></a>
							<a href="#" title="ebooks_standards"><span><img src="${contextPath}/resources/data1/tooltips/ebooks_standards.png" alt="ebooks_standards"/>9</span></a>
							<a href="#" title="PA_flow"><span><img src="${contextPath}/resources/data1/tooltips/pa_flow.jpg" alt="PA_flow"/>10</span></a>
							<a href="#" title="PA_helps"><span><img src="${contextPath}/resources/data1/tooltips/pa_helps.jpg" alt="PA_helps"/>11</span></a>
							<a href="#" title="oneassistantallneeds"><span><img src="${contextPath}/resources/data1/tooltips/oneassistantallneeds.jpg" alt="oneassistantallneeds"/>12</span></a>
						</div></div><div class="ws_script" style="position:absolute;left:-99%"><a href="http://wowslider.net">javascript slideshow</a> by WOWSlider.com v8.8</div>
					<div class="ws_shadow"></div>
					</div>	
					<div class="intro-texts" style="margin-top: -90px;">
		            	<h1 class="text-white">Make you feel happy !!!</h1>
		            	<p>SM is a social network template that can be used to connect people. The template offers Landing pages, News Feed, Image/Video Feed, Chat Box, Timeline and lot more. <br /> <br />Why are you waiting for? Buy it now.</p>
		              <button class="btn btn-primary">Learn More</button>
		            </div>
          </div>
        	<div class="col-sm-6 col-sm-offset-1">
            <div class="reg-form-container"> 
            
              <!-- Register/Login Tabs-->
              <div class="reg-options">
                <ul class="nav nav-tabs">
                   <li class="active"><a href="${contextPath}/signup" >Register</a></li>
                  <li ><a href="${contextPath}/login" >Login</a></li>
                </ul><!--Tabs End-->
              </div>
              
              <!--Registration Form Contents-->
              <div class="tab-content">
                <div >
                  <h3>Register Now </h3>
                  <p class="text-muted">Be cool and join today. Make you feel happy.</p>
                  <c:if test="${not empty message}">
		       	    	<c:if test="${flag}"><div class="alert alert-danger" role="alert">	</c:if>
		       	    	<c:if test="${flag eq false}"><div class="alert alert-success" role="alert">	</c:if>
			           	  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						  <strong>${message}</strong> 
						</div>
					</c:if>
                  <!--Register Form-->
                  <form action="${contextPath}/signup" method="post" id='registration_form' class="form-inline">
                    <div class="row">
                      <div class="form-group col-xs-6">
                        <label for="firstname" class="sr-only">First Name</label>
                        <input id="firstname" class="form-control input-group-lg" type="text" name="firstname" title="Enter first name" placeholder="First name"/>
                      </div>
                      <div class="form-group col-xs-6">
                        <label for="lastname" class="sr-only">Last Name</label>
                        <input id="lastname" class="form-control input-group-lg" type="text" name="lastname" title="Enter last name" placeholder="Last name"/>
                      </div>
                    </div>
                    <div class="row">
                      <div class="form-group col-xs-12">
                        <label for="email" class="sr-only">Email</label>
                        <input id="email" class="form-control input-group-lg" type="text" name="email" title="Enter Email" placeholder="Your Email"/>
                      </div>
                    </div>
                    <div class="row">
                      <div class="form-group col-xs-12">
                        <label for="mobile_no" class="sr-only">Mobile no</label>
                        <input id="mobile_no" class="form-control input-group-lg" type="text" name="mobile_no" title="Mobile Number" placeholder="Your Mobile Number"/>
                      </div>
                    </div>
                    <div class="row">
                      <div class="form-group col-xs-12">
                        <label for="password" class="sr-only">Password</label>
                        <input id="password" class="form-control input-group-lg" type="password" name="password" title="Enter password" placeholder="Password"/>
                      </div>
                    </div>
                     <div class="row">
                     <div class="form-group col-xs-12">
                       <select class="form-control" name="gender">
                          <option value="" >select gender</option>
                          <option value="M">Male</option>
                           <option value="F">Female</option>
                        </select>
                      </div>
                    </div>
                    <div class="row">
                      <p class="birth"><strong>Date of Birth</strong></p>
                      <div class="form-group col-sm-3 col-xs-6">
                        <label for="month" class="sr-only"></label>
                        <select name="birthday_date" class="form-control" id="day">
                          <option value="Day" disabled selected>Day</option>
                           <% for(int i=1;i<=31;i++) { %>	
                          <option value="<%=i%>"><%=i%></option>
                          <% }%>
                        </select>
                      </div>
                      <div class="form-group col-sm-3 col-xs-6">
                        <label for="month" class="sr-only"></label>
                        <select name="birthday_month" class="form-control" id="month">
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
                        <select name="birthday_year" class="form-control" id="year">
                          <option value="year" disabled selected>Year</option>
                          <% for(int i=1900;i<=2017;i++) { %>	
                          <option value="<%=i%>"><%=i%></option>
                          <% }%>
                        </select>
                      </div>
                    </div>
                    <div class="row">
                      <div class="form-group col-xs-6">
                        <label for="city" class="sr-only">City</label>
                        <input id="city" class="form-control input-group-lg reg_name" type="text" name="city" title="Enter city" placeholder="Your city"/>
                      </div>
                      <div class="form-group col-xs-6">
                        <label for="country" class="sr-only"></label>
                        <select name="country" class="form-control" id="country">
                          <option value="" disabled selected>Country</option>
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
                          <option value="CIV">C??d'Ivoire</option>
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
                          <option value="USA">United States</option>
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
                     <%-- <p><a href="${contextPath}/login" data-toggle="tab">Already have an account?</a></p> --%>
                  	<button type="submit" class="btn btn-primary">Register Now</button>
                  </form>
                 
                </div>
                
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-6 col-sm-offset-6">
          
            <!--Social Icons-->
            <ul class="list-inline social-icons">
              <li><a href="#"><i class="icon ion-social-facebook"></i></a></li>
              <li><a href="#"><i class="icon ion-social-twitter"></i></a></li>
              <li><a href="#"><i class="icon ion-social-googleplus"></i></a></li>
              <li><a href="#"><i class="icon ion-social-pinterest"></i></a></li>
              <li><a href="#"><i class="icon ion-social-linkedin"></i></a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <!--preloader-->
   <!--  <div id="spinner-wrapper">
      <div class="spinner"></div>
    </div> -->
    

    <!-- Scripts
    ================================================= -->
    <script src="${contextPath}/resources/default/js/jquery-3.1.1.min.js"></script>
    <script src="${contextPath}/resources/default/js/bootstrap.min.js"></script>
    <script src="${contextPath}/resources/default/js/jquery.appear.min.js"></script>
	<script src="${contextPath}/resources/default/js/jquery.incremental-counter.js"></script>
    <script src="${contextPath}/resources/default/js/script.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/engine1/wowslider.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/engine1/script.js"></script>
	</body>

<!-- Mirrored from thunder-team.com/friend-finder/index-register.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 18 Oct 2017 07:24:12 GMT -->
</html>

