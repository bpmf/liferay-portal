<%--
/**
 * Copyright (c) 2000-2012 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="com.liferay.portlet.blogs.model.BlogsEntry" %><%@
page import="com.liferay.portlet.blogs.service.BlogsEntryServiceUtil" %><%@
page import="com.liferay.portlet.blogs.service.permission.BlogsEntryPermission" %><%@
page import="com.liferay.portlet.messageboards.service.MBMessageLocalServiceUtil" %><%@
page import="com.liferay.util.RSSUtil" %>

<%
PortletPreferences preferences = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	preferences = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource);
}

String selectionMethod = preferences.getValue("selectionMethod", "users");
long organizationId = GetterUtil.getLong(preferences.getValue("organizationId", "0"));
String displayStyle = preferences.getValue("displayStyle", "abstract");
int max = GetterUtil.getInteger(preferences.getValue("max", "20"));
boolean showTags = GetterUtil.getBoolean(preferences.getValue("showTags", null), true);

boolean enableRSS = !PortalUtil.isRSSFeedsEnabled() ? false : GetterUtil.getBoolean(preferences.getValue("enableRss", null), true);
int rssDelta = GetterUtil.getInteger(preferences.getValue("rssDelta", StringPool.BLANK), SearchContainer.DEFAULT_DELTA);
String rssDisplayStyle = preferences.getValue("rssDisplayStyle", RSSUtil.DISPLAY_STYLE_DEFAULT);
String rssFeedType = preferences.getValue("rssFeedType", RSSUtil.FEED_TYPE_DEFAULT);

if (organizationId == 0) {
	Group group = GroupLocalServiceUtil.getGroup(scopeGroupId);

	if (group.isOrganization()) {
		organizationId = group.getOrganizationId();
	}
}

Format dateFormatDateTime = FastDateFormatFactoryUtil.getDateTime(locale, timeZone);
%>

<%@ include file="/html/portlet/blogs_aggregator/init-ext.jsp" %>