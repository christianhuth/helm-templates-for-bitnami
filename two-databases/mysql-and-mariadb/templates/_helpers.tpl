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
Return the hostname of the database to use
*/}}
{{- define "mychart.database.hostname" -}}
  {{- if .Values.mysql.enabled -}}
    {{- printf "%s" (include "mysql.primary.fullname" .Subcharts.mysql) -}}
  {{- else if .Values.mariadb.enabled -}}
    {{- printf "%s" (include "mariadb.primary.fullname" .Subcharts.mariadb) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalDatabase.hostname $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return database service port
*/}}
{{- define "mychart.database.port" -}}
  {{- if .Values.mysql.enabled -}}
    {{- printf "%s" (tpl (toString .Values.mysql.primary.service.ports.mysql) $) -}}
  {{- else if .Values.mariadb.enabled -}}
    {{- printf "%s" (tpl (toString .Values.mariadb.primary.service.ports.mysql) $) -}}
  {{- else -}}
    {{- printf "%s" (tpl (toString .Values.externalDatabase.port) $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the name for the database to use
*/}}
{{- define "mychart.database.database" -}}
  {{- if .Values.mysql.enabled -}}
    {{- printf "%s" (tpl .Values.mysql.auth.database $) -}}
  {{- else if .Values.mariadb.enabled -}}
    {{- printf "%s" (tpl .Values.mariadb.auth.database $) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalDatabase.auth.database $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the name for the user to use
*/}}
{{- define "mychart.database.username" -}}
  {{- if .Values.mysql.enabled -}}
    {{- printf "%s" (tpl .Values.mysql.auth.username $) -}}
  {{- else if .Values.mariadb.enabled -}}
    {{- printf "%s" (tpl .Values.mariadb.auth.username $) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalDatabase.auth.username $) -}}
  {{- end -}}
{{- end -}}

{{/*
Get the name of the secret containing the database user password
*/}}
{{- define "mychart.database.secretName" -}}
  {{- if .Values.mysql.enabled -}}
    {{- printf "%s" (include "mysql.secretName" .Subcharts.mysql) -}}
  {{- else if .Values.mariadb.enabled -}}
    {{- printf "%s" (include "mariadb.secretName" .Subcharts.mariadb) -}}
  {{- else if .Values.externalDatabase.auth.existingSecret -}}
    {{- printf "%s" (tpl .Values.externalDatabase.auth.existingSecret $) -}}
  {{- else -}}
      {{- printf "%s" (include "mychart.fullname" .) -}}-database
  {{- end -}}
{{- end -}}

{{/*
Get the user-password key for the database password
*/}}
{{- define "mychart.database.userPasswordKey" -}}
  {{- if .Values.mysql.enabled -}}
    {{- "mysql-password" -}}
  {{- else if .Values.mariadb.enabled -}}
    {{- "mariadb-password" -}}
  {{- else if .Values.externalDatabase.auth.userPasswordKey -}}
    {{- printf "%s" (tpl .Values.externalDatabase.auth.userPasswordKey $) -}}
  {{- else -}}
    {{- "password" -}}
  {{- end -}}
{{- end -}}

{{/*
Get the type of the external database
*/}}
{{- define "mychart.database.type" -}}
  {{- if .Values.mysql.enabled -}}
    {{- "mysql" -}}
  {{- else if .Values.mariadb.enabled -}}
    {{- "mariadb" -}}
  {{- else if .Values.externalDatabase.type -}}
    {{- printf "%s" (tpl .Values.externalDatabase.type $) -}}
  {{- end -}}
{{- end -}}
