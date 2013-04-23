<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:func = "http://exslt.org/functions"
    xmlns:gsa="http://openvas.org"
    extension-element-prefixes="func">
    <xsl:output
      method="html"
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
      doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
      encoding="UTF-8"/>

<!--
Greenbone Security Assistant
$Id$
Description: Main stylesheet

Authors:
Matthew Mundell <matthew.mundell@greenbone.net>
Jan-Oliver Wagner <jan-oliver.wagner@greenbone.net>
Michael Wiegand <michael.wiegand@greenbone.net>
Karl-Heinz Ruskowski <khruskowski@intevation.de>
Timo Pollmeier <timo.pollmeier@greenbone.net>

Copyright:
Copyright (C) 2009, 2010, 2012, 2013 Greenbone Networks GmbH

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License version 2,
or, at your option, any later version as published by the Free
Software Foundation

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
-->

<!-- XPATH FUNCTIONS -->

<func:function name="gsa:i18n">
  <xsl:param name="str"/>
  <func:result>
    <xsl:choose>
      <xsl:when test="substring(/envelope/i18n, 1, 2) = 'de' and
                      document('po/de.xml')//i18n/msg[normalize-space(id) = normalize-space($str)]/str">
        <xsl:value-of select="document('po/de.xml')//i18n/msg[normalize-space(id) = normalize-space($str)]/str"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$str"/>
      </xsl:otherwise>
    </xsl:choose>
  </func:result>
</func:function>

<!-- HEADERS, FOOTER, SIDEBARS -->

<xsl:template name="html-head">
  <head>
    <link rel="stylesheet" type="text/css" href="/gsa-style.css"/>
    <link rel="icon" href="/favicon.gif" type="image/x-icon"/>
    <title>Greenbone Security Assistant</title>
    <xsl:apply-templates select="envelope/autorefresh" mode="html-header-meta" />
  </head>
</xsl:template>

<!-- Add meta refresh info if autorefresh element present -->
<xsl:template match="autorefresh" mode="html-header-meta">
  <xsl:if test="@interval &gt; 0">
    <meta http-equiv="refresh" content="{@interval};{/envelope/caller}&amp;token={/envelope/token}" />
  </xsl:if>
</xsl:template>

<xsl:template name="indicator">
  <xsl:param name="status"/>
  <xsl:param name="status_text"/>
  <xsl:param name="command"/>
  <xsl:choose>
    <xsl:when test="substring($status, 1, 1) = '2'">
      <img src="/img/indicator_operation_ok.png"
           alt="Result of {$command}: {$status_text}"
           title="Result of {$command}: {$status_text}"
           style="margin-right:3px;"/>
    </xsl:when>
    <xsl:otherwise>
      <img src="/img/indicator_operation_failed.png"
           alt="Result of {$command}: {$status_text}"
           title="Result of {$command}: {$status_text}"
           style="margin-right:3px;"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Manager indicators. -->

<xsl:template match="create_agent_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Agent'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_config_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Config'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_alert_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Alert'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_filter_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Filter'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_group_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Group'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_lsc_credential_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Credential'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_note_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Note'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_override_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Override'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_port_list_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Port List'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_port_range_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Port Range'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_report_format_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Report Format'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_report_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Container Task'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_schedule_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Schedule'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_slave_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Slave'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_tag_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Tag'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_target_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Target'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="create_task_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create Task'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_agent_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Agent'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_config_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Config'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_alert_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Alert'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_filter_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Filter'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_lsc_credential_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Credential'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_note_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Note'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_override_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Override'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_permission_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Permission'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_port_list_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Port List'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_port_range_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Port Range'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_report_format_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Report Format'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_report_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Report'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_schedule_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Schedule'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_slave_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Slave'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_tag_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Tag'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_target_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Target'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_task_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete Task'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="empty_trashcan_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Empty Trashcan'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="get_overrides_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Get Overrides'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="get_reports_alert_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Alert'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="get_reports_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Get Report'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="get_results_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Get Result'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="get_system_reports_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Get System Reports'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="gsad_msg" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="@operation"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_agent_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Agent'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_alert_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Alert'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_filter_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Filter'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_group_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Group'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_lsc_credential_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Credential'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_note_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Modify Note'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_override_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Modify Override'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_port_list_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Port List'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_report_format_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Modify Report Format'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_schedule_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Schedule'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_slave_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Slave'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_tag_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Tag'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_target_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Target'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_task_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Task'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="restore_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Restore'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="run_wizard_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Run Wizard'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="start_task_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Start Task'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="stop_task_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Stop Task'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="pause_task_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Pause Task'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="resume_paused_task_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Resume Task'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="resume_stopped_task_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Resume Stopped Task'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="test_alert_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Test Alert'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="verify_agent_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Verify Agent'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="verify_report_format_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Verify Report Format'"/>
  </xsl:call-template>
</xsl:template>

<!-- Administrator indicators. -->

<xsl:template match="create_user_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Create User'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="delete_user_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Delete User'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="get_settings_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Edit Settings'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_auth_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Auth'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_settings_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save Settings'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="modify_user_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Save User'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="sync_feed_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Synchronization with NVT Feed'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="sync_scap_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Synchronization with SCAP Feed'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="sync_cert_response" mode="response-indicator">
  <xsl:call-template name="indicator">
    <xsl:with-param name="status" select="@status"/>
    <xsl:with-param name="status_text" select="@status_text"/>
    <xsl:with-param name="command" select="'Synchronization with CERT Feed'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="html-gsa-logo">
  <xsl:param name="username"/>
  <xsl:param name="time"/>
  <div style="text-align:left;">
    <div class="logo_l">
      <a href="/omp?cmd=get_tasks&amp;overrides=1&amp;token={/envelope/token}" title="Greenbone Security Assistant">
        <img src="/img/style/logo_l.png" alt="Greenbone Security Assistant"/>
      </a>
    </div>
    <div class="logo_r"></div>
    <div class="logo_m">
      <div class="logout_panel">
        <xsl:choose>
          <xsl:when test="$username = ''">
          </xsl:when>
          <xsl:when test="string-length ($username) &gt; 45">
            <xsl:value-of select="gsa:i18n('Logged in as')"/>
            <div style="display: inline;margin-left:3px"><xsl:value-of select="/envelope/role"/></div>
            <b><a href="/omp?cmd=get_my_settings&amp;token={/envelope/token}"><xsl:value-of select="substring ($username, 1, 45)"/>...</a></b> |
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="gsa:i18n('Logged in as')"/>
            <div style="display: inline;margin-left:3px"><xsl:value-of select="/envelope/role"/></div>
            <b><a href="/omp?cmd=get_my_settings&amp;token={/envelope/token}"><xsl:value-of select="$username"/></a></b> |
          </xsl:otherwise>
        </xsl:choose>
        <a href="/logout?token={/envelope/token}" title="Logout" style="margin-left:3px;">
          <xsl:value-of select="gsa:i18n('Logout')"/>
        </a>
        <br/>
        <br/>
        <xsl:value-of select="$time"/>
      </div>
      <div class="status_panel">
        <xsl:apply-templates select="gsad_msg"
                             mode="response-indicator"/>

        <!-- Manager -->
        <xsl:apply-templates select="commands_response/create_agent_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="commands_response/create_config_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="commands_response/create_lsc_credential_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="commands_response/create_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="commands_response/create_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_task/delete_report_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/create_report_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/create_task_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="commands_response/delete_agent_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_config/commands_response/delete_config_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_configs/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_configs/delete_config_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="commands_response/delete_task_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_lsc_credential/modify_lsc_credential_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_lsc_credentials/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_lsc_credentials/modify_lsc_credential_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_lsc_credential/commands_response/delete_lsc_credential_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_lsc_credentials/delete_lsc_credential_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="commands_response/modify_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="commands_response/modify_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="edit_task/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="edit_lsc_credential/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="edit_user/modify_user_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_agents/commands_response/verify_agent_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_agents/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_agent/modify_agent_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_agents/modify_agent_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_agents/verify_agent_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_agent/commands_response/delete_agent_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_agents/delete_agent_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_alert/commands_response/delete_alert_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_alert/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_alert/modify_alert_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_alerts/modify_alert_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_alerts/create_alert_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_alerts/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_alerts/delete_alert_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_alerts/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_alerts/test_alert_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_delta_result/create_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_delta_result/delete_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_delta_result/modify_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_filter/delete_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_filter/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_filter/modify_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_filters/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_filters/delete_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_filters/modify_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_group/modify_group_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_groups/modify_group_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_lsc_credential/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_note/modify_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_notes/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_notes/create_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_notes/delete_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_notes/modify_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_nvts/commands_response/delete_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_nvts/commands_response/delete_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_nvts/commands_response/modify_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_nvts/commands_response/modify_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_nvts/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_override/modify_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_overrides/delete_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_overrides/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_overrides/modify_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_overrides/modify_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_override/commands_response/modify_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_overrides/commands_response/modify_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_permissions/delete_permission_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_port_lists/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_port_lists/create_port_list_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_port_lists/commands_response/delete_port_list_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_port_list/modify_port_list_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_port_lists/modify_port_list_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_port_list/create_port_range_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_port_list/commands_response/delete_port_list_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_port_lists/delete_port_list_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report/create_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report/create_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report/delete_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report/delete_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report/get_reports_alert_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report/modify_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report/modify_override_response"
                             mode="response-indicator"/>
<!--
        <xsl:apply-templates select="get_report/get_reports_response"
                             mode="response-indicator"/>
-->
        <xsl:apply-templates select="get_report_format/commands_response/delete_report_format_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report_formats/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report_formats/delete_report_format_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report_formats/modify_report_format_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report_formats/create_report_format_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report_format/modify_report_format_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_report_formats/verify_report_format_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_result/commands_response/create_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_result/create_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_result/delete_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_result/commands_response/create_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_result/create_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_result/delete_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_result/commands_response/modify_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_result/commands_response/modify_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_schedule/commands_response/delete_schedule_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_schedule/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_schedules/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_schedules/create_schedule_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_schedules/commands_response/delete_schedule_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_schedules/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_schedule/modify_schedule_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_schedules/modify_schedule_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_schedules/delete_schedule_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_slave/modify_slave_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_slaves/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_slaves/modify_slave_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_slaves/delete_slave_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_slave/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_slaves/commands_response/delete_slave_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_slaves/create_slave_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_slaves/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_system_reports/get_system_reports_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tag/commands_response/delete_tag_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tag/create_tag_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tag/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tag/create_tag_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tag/delete_tag_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tag/modify_tag_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tags/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tags/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tags/create_tag_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tags/delete_tag_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tags/modify_tag_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_target/commands_response/delete_target_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_target/create_target_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_target/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_targets/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_targets/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_targets/create_target_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_targets/delete_target_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/delete_task_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/modify_note_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/modify_override_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_targets/modify_target_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_target/modify_target_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/modify_task_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/start_task_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/stop_task_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/pause_task_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/resume_paused_task_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/resume_stopped_task_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_trash/delete_agent_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_trash/delete_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_trash/delete_config_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_trash/delete_alert_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_trash/delete_lsc_credential_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_trash/delete_report_format_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_trash/delete_schedule_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_trash/delete_slave_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_trash/delete_target_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_trash/delete_task_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_trash/empty_trashcan_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_trash/restore_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_tasks/run_wizard_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_users/create_user_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_users/delete_user_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_users/modify_user_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_users/modify_auth_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="new_filter/create_filter_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="new_group/create_group_response"
                             mode="response-indicator"/>

        <!-- Administrator -->
        <xsl:apply-templates select="commands_response/modify_settings_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="commands_response/sync_feed_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="commands_response/sync_scap_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="commands_response/sync_cert_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="edit_settings/get_settings_response"
                             mode="response-indicator"/>
        <xsl:apply-templates select="edit_settings/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_settings/gsad_msg"
                             mode="response-indicator"/>
        <xsl:apply-templates select="get_users/gsad_msg"
                             mode="response-indicator"/>

        <a href="/help/javascript.html?token={/envelope/token}" title="Greenbone Security Assistant">
          <script type="text/javascript">
            document.write ("&lt;img src=\"/img/indicator_js.png\" alt=\"JavaScript is active\" title=\"JavaScript is active\"/&gt;");
          </script>
          <noscript></noscript>
        </a>
      </div>
    </div>
  </div>
  <br clear="all"/>
</xsl:template>

<xsl:template name="html-footer">
  <div class="gsa_footer">
    Greenbone Security Assistant (GSA) Copyright 2009-2013 by Greenbone Networks
    GmbH, <a href="http://www.greenbone.net" target="_blank">www.greenbone.net</a>
  </div>
</xsl:template>

<xsl:template name="html-gsa-navigation">
 <center>
  <div id="gb_menu">
   <ul>
    <li class="first_button">
     <a href="/omp?cmd=get_tasks&amp;overrides=1&amp;token={/envelope/token}">Scan Management</a>
     <ul>
      <li class="pointy"></li>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_TASKS']">
        <li><a href="/omp?cmd=get_tasks&amp;overrides=1&amp;token={/envelope/token}">
              <xsl:value-of select="gsa:i18n('Tasks')"/>
            </a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='CREATE_TASK'] and /envelope/capabilities/help_response/schema/command[name='GET_TARGETS'] and /envelope/capabilities/help_response/schema/command[name='GET_CONFIGS']">
        <li><a href="/omp?cmd=new_task&amp;overrides=1&amp;token={/envelope/token}">
              <xsl:value-of select="gsa:i18n('New Task')"/>
            </a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_NOTES']">
        <li><a href="/omp?cmd=get_notes&amp;filter=sort=nvt&amp;token={/envelope/token}">
              <xsl:value-of select="gsa:i18n('Notes')"/>
            </a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_OVERRIDES']">
        <li class="last"><a href="/omp?cmd=get_overrides&amp;token={/envelope/token}">
              <xsl:value-of select="gsa:i18n('Overrides')"/>
            </a></li>
      </xsl:if>
     </ul>
    </li>
    <li>
      <a href="/omp?cmd=get_report&amp;type=assets&amp;overrides=1&amp;levels=hm&amp;token={/envelope/token}">Asset Management</a>
      <ul>
       <li class="pointy"></li>
       <li class="last"><a href="/omp?cmd=get_report&amp;type=assets&amp;overrides=1&amp;levels=hm&amp;token={/envelope/token}">Hosts</a></li>
      </ul>
    </li>
    <li>
     <a href="/omp?cmd=get_info&amp;info_type=nvt&amp;token={/envelope/token}">SecInfo Management</a>
     <ul>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_INFO']">
       <li class="pointy"></li>
       <li><a href="/omp?cmd=get_info&amp;info_type=nvt&amp;token={/envelope/token}">NVTs</a></li>
       <li><a href="/omp?cmd=get_info&amp;info_type=cve&amp;token={/envelope/token}">CVEs</a></li>
       <li><a href="/omp?cmd=get_info&amp;info_type=cpe&amp;token={/envelope/token}">CPEs</a></li>
       <li><a href="/omp?cmd=get_info&amp;info_type=ovaldef&amp;token={/envelope/token}">OVAL Definitions</a></li>
       <li><a href="/omp?cmd=get_info&amp;info_type=dfn_cert_adv&amp;token={/envelope/token}">DFN-CERT Advisories</a></li>
       <li class="last"><a href="/omp?cmd=get_info&amp;info_type=allinfo&amp;token={/envelope/token}">All SecInfo</a></li>
      </xsl:if>
     </ul>
    </li>
    <li>
     <a href="/omp?cmd=get_targets&amp;token={/envelope/token}">Configuration</a>
     <ul>
      <li class="pointy"></li>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_TARGETS']">
        <li><a href="/omp?cmd=get_targets&amp;token={/envelope/token}">
              <xsl:value-of select="gsa:i18n('Targets')"/>
            </a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_PORT_LISTS']">
        <li class="indent"><a href="/omp?cmd=get_port_lists&amp;token={/envelope/token}">Port Lists</a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_LSC_CREDENTIALS']">
        <li class="indent"><a href="/omp?cmd=get_lsc_credentials&amp;token={/envelope/token}">Credentials</a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_CONFIGS']">
        <li><a href="/omp?cmd=get_configs&amp;token={/envelope/token}">Scan Configs</a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_ALERTS']">
        <li><a href="/omp?cmd=get_alerts&amp;token={/envelope/token}">Alerts</a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_TAGS']">
        <li><a href="/omp?cmd=get_tags&amp;token={/envelope/token}">Tags</a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_FILTERS']">
        <li><a href="/omp?cmd=get_filters&amp;token={/envelope/token}">Filters</a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_SCHEDULES']">
        <li><a href="/omp?cmd=get_schedules&amp;token={/envelope/token}">Schedules</a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_REPORT_FORMATS']">
        <li><a href="/omp?cmd=get_report_formats&amp;token={/envelope/token}">Report Formats</a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_SLAVES']">
        <li><a href="/omp?cmd=get_slaves&amp;token={/envelope/token}">Slaves</a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_AGENTS']">
        <li><a href="/omp?cmd=get_agents&amp;token={/envelope/token}">Agents</a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_PERMISSIONS']">
        <li class="last"><a href="/omp?cmd=get_permissions&amp;token={/envelope/token}">Permissions</a></li>
      </xsl:if>
     </ul>
    </li>
    <li>
     <a href="/omp?cmd=get_trash&amp;token={/envelope/token}">Extras</a>
     <ul>
      <li class="pointy"></li>
      <li><a href="/omp?cmd=get_trash&amp;token={/envelope/token}">Trashcan</a></li>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_SETTINGS']">
        <li><a href="/omp?cmd=get_my_settings&amp;token={/envelope/token}">My Settings</a></li>
      </xsl:if>
      <xsl:if test="/envelope/capabilities/help_response/schema/command[name='GET_SYSTEM_REPORTS']">
        <li class="last"><a href="/omp?cmd=get_system_reports&amp;duration=86400&amp;slave_id=0&amp;token={/envelope/token}">Performance</a></li>
      </xsl:if>
      <li><a href="/omp?cmd=cvss_calculator&amp;token={/envelope/token}">CVSS Calculator</a></li>
     </ul>
    </li>
    <li>
     <a href="/oap?cmd=get_users&amp;token={/envelope/token}">Administration</a>
     <ul>
      <li class="pointy"></li>
      <li><a href="/oap?cmd=get_users&amp;token={/envelope/token}">Users</a></li>
      <li><a href="/oap?cmd=get_groups&amp;token={/envelope/token}">Groups</a></li>
      <li><a href="/oap?cmd=get_feed&amp;token={/envelope/token}">NVT Feed</a></li>
      <li><a href="/oap?cmd=get_scap&amp;token={/envelope/token}">SCAP Feed</a></li>
      <li><a href="/oap?cmd=get_cert&amp;token={/envelope/token}">CERT Feed</a></li>
      <li class="last"><a href="/oap?cmd=get_settings&amp;token={/envelope/token}">Settings</a></li>
     </ul>
    </li>
    <li class="last_button">
     <a href="/help/contents.html?token={/envelope/token}">Help</a>
     <ul>
      <li class="pointy"></li>
      <li><a href="/help/contents.html?token={/envelope/token}">Contents</a></li>
      <li class="last"><a href="/help/about.html?token={/envelope/token}">About</a></li>
     </ul>
    </li>
   </ul>
  </div>
  <br clear="all" />
  <br />
 </center>
</xsl:template>

<!-- DIALOGS -->

<xsl:template name="error_window">
  <xsl:param name="heading">Error Message</xsl:param>
  <xsl:param name="message">(Missing message)</xsl:param>
  <xsl:param name="token"></xsl:param>
  <div class="gb_window">
    <div class="gb_window_part_left_error"></div>
    <div class="gb_window_part_right_error"></div>
    <div class="gb_window_part_center_error">
      <xsl:value-of select="$heading"/>
    </div>
    <div class="gb_window_part_content_error">
<!--
      <div class="float_right">
        <a href="/help/error_messages.html?token={$token}" title="Help: Error Message">
          <img src="/img/help.png"/>
        </a>
      </div>
      <span>
        <img src="/img/alert_sign.png" alt="" title="{$heading}"
             style="margin-left:10px; margin-top:10px; text-align:left;"/>
      </span>
-->
      <center>
        <div style="width:500px;">
          <xsl:copy-of select="$message"/>
        </div>
      </center>
    </div>
  </div>
</xsl:template>

<xsl:template name="error_dialog">
  <xsl:param name="title">(Missing title)</xsl:param>
  <xsl:param name="message">(Missing message)</xsl:param>
  <xsl:param name="backurl">/omp?cmd=get_tasks&amp;overrides=1</xsl:param>
  <xsl:param name="token"></xsl:param>
  <center>
    <div class="envelope" style="width:500px;">
      <div class="gb_window" style="margin-top:150px;">
        <div class="gb_window_part_left_error"></div>
        <div class="gb_window_part_right_error"></div>
        <div class="gb_window_part_center_error">Error Message</div>
        <div class="gb_window_part_content_error" style="text-align:center;">
          <div class="float_right">
            <a href="/help/error_messages.html?token={$token}" title="Help: Error Message">
              <img src="/img/help.png"/>
            </a>
          </div>
          <br/>
          <img src="/img/alert_sign.png" alt="" title="{$title}"
               style="float:left;margin-left:10px;"/>
          <span style="font-size:16px;">
            <div style="font-weight:bold;padding-top:12px;font-size:20px;">
              <xsl:value-of select="$title"/>
            </div>
            <br clear="all"/>
            <xsl:value-of select="$message"/>
          </span>
          <div style="margin-top:10px;">
            Your options (not all may work):<br/>
            'Back' button of browser
            <xsl:choose>
              <xsl:when test="string-length ($token) &gt; 0">
                <xsl:choose>
                  <xsl:when test="contains ($backurl, '?')">
                    | <a href="{$backurl}&amp;token={$token}">Assumed sane state</a>
                  </xsl:when>
                  <xsl:otherwise>
                    | <a href="{$backurl}?token={$token}">Assumed sane state</a>
                  </xsl:otherwise>
                </xsl:choose>
                | <a href="/logout?token={$token}">Logout</a>
              </xsl:when>
              <xsl:otherwise>
                | <a href="/login/login.html">Login</a>
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>
      </div>
      <xsl:call-template name="html-footer"/>
    </div>
  </center>
</xsl:template>

<!-- GSAD_RESPONSE -->

<xsl:template match="gsad_response">
  <xsl:call-template name="error_dialog">
    <xsl:with-param name="title">
      <xsl:value-of select="title"/>
    </xsl:with-param>
    <xsl:with-param name="message">
      <xsl:value-of select="message"/>
    </xsl:with-param>
    <xsl:with-param name="backurl">
      <xsl:value-of select="backurl"/>
    </xsl:with-param>
    <xsl:with-param name="token">
      <xsl:value-of select="token"/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!-- COMMON TEMPLATES -->

<xsl:template name="command_result_dialog">
  <xsl:param name="operation">(Operation description is missing)</xsl:param>
  <xsl:param name="status">(Status code is missing)</xsl:param>
  <xsl:param name="msg">(Status message is missing)</xsl:param>
  <xsl:param name="details"></xsl:param>

  <xsl:choose>
    <xsl:when test="$status = '200' or $status = '201' or $status = '202'">
    </xsl:when>
    <xsl:otherwise>
      <div class="gb_window">
        <div class="gb_window_part_left_error"></div>
        <div class="gb_window_part_right_error"></div>
        <div class="gb_window_part_center_error">
          Results of last operation
        </div>

        <div class="gb_window_part_content_no_pad">
          <div style="text-align:left;">
            <table>
              <xsl:choose>
                <xsl:when test="$operation = ''">
                </xsl:when>
                <xsl:otherwise>
                  <tr>
                    <td>Operation:</td>
                    <td><xsl:value-of select="$operation"/></td>
                  </tr>
                </xsl:otherwise>
              </xsl:choose>

              <xsl:choose>
                <xsl:when test="$status = ''">
                </xsl:when>
                <xsl:otherwise>
                  <tr>
                    <td>Status code:</td>
                    <td><xsl:value-of select="$status"/></td>
                  </tr>
                </xsl:otherwise>
              </xsl:choose>

              <tr>
                <td>Status message:</td>
                <td><xsl:value-of select="$msg"/></td>
              </tr>
            </table>

            <xsl:choose>
              <xsl:when test="$details = ''">
              </xsl:when>
              <xsl:otherwise>
                <table><tr><td><xsl:value-of select="$details"/></td></tr></table>
              </xsl:otherwise>
            </xsl:choose>

          </div>
        </div>
      </div>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- OMP -->

<xsl:include href="omp.xsl"/>

<!-- OAP -->

<xsl:include href="oap.xsl"/>

<!-- Help -->

<xsl:include href="help.xsl"/>

<!-- Wizards -->

<xsl:include href="wizard.xsl"/>

<!-- Login page -->

<xsl:template match="login_page">
  <div style="width:315px;margin-top:5px;">
    <div class="gb_window">
      <div class="gb_window_part_left"></div>
      <div class="gb_window_part_right"></div>
      <div class="gb_window_part_center">Greenbone Security Assistant</div>
      <div class="gb_window_part_content">
        <img src="/img/gsa_splash.png" alt="" />
        <center>
          <div style="color: red"><xsl:value-of select="message"/></div>
          <form action="/omp" method="post" enctype="multipart/formdata">
            <input type="hidden" name="cmd" value="login" />
            <xsl:choose>
              <xsl:when test="string-length(url) = 0">
                <input type="hidden" name="text" value="/omp?cmd=get_tasks&amp;overrides=1" />
              </xsl:when>
              <xsl:otherwise>
                <input type="hidden" name="text" value="{url}" />
              </xsl:otherwise>
            </xsl:choose>
            <table>
              <tr>
                <td>Username</td>
                <td><input type="text" autocomplete="off" name="login" value="" autofocus="autofocus"/></td>
              </tr>
              <tr>
                <td>Password</td>
                <td><input type="password" autocomplete="off" name="password" value="" /></td>
              </tr>
            </table>
            <div style="text-align:center;float:center;"><input type="submit" value="Login" /></div>
            <br clear="all" />
          </form>
        </center>
      </div>
    </div>
  </div>
</xsl:template>

<!-- ROOT, ENVELOPE -->

<xsl:template match="params">
</xsl:template>

<xsl:template match="caller">
</xsl:template>

<xsl:template match="token">
</xsl:template>

<xsl:template match="login">
</xsl:template>

<xsl:template match="time">
</xsl:template>

<xsl:template match="timezone">
</xsl:template>

<xsl:template match="role">
</xsl:template>

<xsl:template match="i18n">
</xsl:template>

<xsl:template match="help_response">
</xsl:template>

<xsl:template match="envelope">
  <div class="envelope">
    <xsl:call-template name="html-gsa-logo">
      <xsl:with-param name="username">
        <xsl:value-of select="login/text()"/>
      </xsl:with-param>
      <xsl:with-param name="time">
        <xsl:value-of select="time"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="html-gsa-navigation"/>
    <xsl:apply-templates/>
    <xsl:call-template name="html-footer"/>
  </div>
</xsl:template>

<xsl:template match="/">
  <html xmlns="http://www.w3.org/1999/xhtml">
    <xsl:call-template name="html-head"/>
    <body>
      <center>
        <xsl:apply-templates/>
      </center>
    </body>
  </html>
</xsl:template>

</xsl:stylesheet>
