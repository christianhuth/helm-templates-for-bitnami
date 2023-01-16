{{/*
Expand the name of the chart.
*/}}
{{- define "mychart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mychart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the hostname of the mysql to use
*/}}
{{- define "mychart.mysql.hostname" -}}
  {{- if .Values.mysql.enabled -}}
    {{- printf "%s" (include "mysql.primary.fullname" .Subcharts.mysql) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalMysql.hostname $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return mysql service port
*/}}
{{- define "mychart.mysql.port" -}}
  {{- if .Values.mysql.enabled -}}
    {{- printf "%s" (tpl (toString .Values.mysql.primary.service.ports.mysql) $) -}}
  {{- else -}}
    {{- printf "%s" (tpl (toString .Values.externalMysql.port) $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the name for the database to use
*/}}
{{- define "mychart.mysql.database" -}}
  {{- if .Values.mysql.enabled -}}
    {{- printf "%s" (tpl .Values.mysql.auth.database $) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalMysql.auth.database $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the name for the user to use
*/}}
{{- define "mychart.mysql.username" -}}
  {{- if .Values.mysql.enabled -}}
    {{- printf "%s" (tpl .Values.mysql.auth.username $) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalMysql.auth.username $) -}}
  {{- end -}}
{{- end -}}

{{/*
Get the name of the secret containing the mysql user password
*/}}
{{- define "mychart.mysql.secretName" -}}
  {{- if .Values.mysql.enabled -}}
    {{- printf "%s" (include "mysql.secretName" .Subcharts.mysql) -}}
  {{- else if .Values.externalMysql.auth.existingSecret -}}
    {{- printf "%s" (tpl .Values.externalMysql.auth.existingSecret $) -}}
  {{- else -}}
      {{- printf "%s" (include "mychart.fullname" .) -}}-mysql
  {{- end -}}
{{- end -}}

{{/*
Get the user-password key for the mysql password
*/}}
{{- define "mychart.mysql.userPasswordKey" -}}
  {{- if .Values.mysql.enabled -}}
    {{- "mysql-password" -}}
  {{- else if .Values.externalMysql.auth.userPasswordKey -}}
    {{- printf "%s" (tpl .Values.externalMysql.auth.userPasswordKey $) -}}
  {{- else -}}
    {{- "password" -}}
  {{- end -}}
{{- end -}}
