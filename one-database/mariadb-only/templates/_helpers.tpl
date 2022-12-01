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
Return the hostname of the mariadb to use
*/}}
{{- define "mychart.mariadb.hostname" -}}
  {{- if .Values.mariadb.enabled -}}
    {{- printf "%s" (include "mariadb.primary.fullname" .Subcharts.mariadb) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalMariadb.hostname $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return mariadb service port
*/}}
{{- define "mychart.mariadb.port" -}}
  {{- if .Values.mariadb.enabled -}}
    {{- printf "%s" (tpl (toString .Values.mariadb.primary.service.ports.mysql) $) -}}
  {{- else -}}
    {{- printf "%s" (tpl (toString .Values.externalMariadb.port) $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the name for the database to use
*/}}
{{- define "mychart.mariadb.database" -}}
  {{- if .Values.mariadb.enabled -}}
    {{- printf "%s" (tpl .Values.mariadb.auth.database $) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalMariadb.auth.database $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the name for the user to use
*/}}
{{- define "mychart.mariadb.username" -}}
  {{- if .Values.mariadb.enabled -}}
    {{- printf "%s" (tpl .Values.mariadb.auth.username $) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalMariadb.auth.username $) -}}
  {{- end -}}
{{- end -}}

{{/*
Get the name of the secret containing the mariadb user password
*/}}
{{- define "mychart.mariadb.secretName" -}}
  {{- if .Values.mariadb.enabled -}}
    {{- printf "%s" (include "mariadb.secretName" .Subcharts.mariadb) -}}
  {{- else if .Values.externalMariadb.auth.existingSecret -}}
    {{- printf "%s" (tpl .Values.externalMariadb.auth.existingSecret $) -}}
  {{- else -}}
      {{- printf "%s" (include "mychart.fullname" .) -}}-mariadb
  {{- end -}}
{{- end -}}

{{/*
Get the user-password key for the mariadb password
*/}}
{{- define "mychart.mariadb.userPasswordKey" -}}
  {{- if .Values.mariadb.enabled -}}
    {{- "mariadb-password" -}}
  {{- else if .Values.externalMariadb.auth.userPasswordKey -}}
    {{- printf "%s" (tpl .Values.externalMariadb.auth.userPasswordKey $) -}}
  {{- else -}}
    {{- "password" -}}
  {{- end -}}
{{- end -}}
