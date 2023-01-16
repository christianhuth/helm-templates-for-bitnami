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
Return the hostname of the MongoDB to use
*/}}
{{- define "mychart.mongodb.hostname" -}}
  {{- if .Values.mongodb.enabled -}}
    {{- if not (eq .Values.architecture "replicaset" ) -}}
      {{- printf "%s" (include "mongodb.fullname" .Subcharts.mongodb) -}}
    {{- else -}}
      {{- printf "%s" (include "mongodb.service.nameOverride" .Subcharts.mongodb) -}}
    {{- end -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalMongoDB.hostname $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return mongodb service port
*/}}
{{- define "mychart.mongodb.port" -}}
  {{- if .Values.mongodb.enabled -}}
    {{- printf "%s" (tpl (toString .Values.mongodb.containerPorts.mongodb) $) -}}
  {{- else -}}
    {{- printf "%s" (tpl (toString .Values.externalMongoDB.port) $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the name for the databases to create
*/}}
{{- define "mychart.mongodb.databases" -}}
  {{- if .Values.mongodb.enabled -}}
    {{- printf "%s" (include "mongodb.customDatabases" .Subcharts.mongodb) -}}
  {{- else -}}
    {{- $customDatabases := list -}}
    {{- range .Values.externalMongoDB.auth.databases }}
      {{- $customDatabases = append $customDatabases . }}
    {{- end }}
    {{- printf "%s" (default "" ((join "," $customDatabases))) -}}
  {{- end -}}
{{- end -}}

{{/*
Define if authentication is activated
*/}}
{{- define "mychart.mongodb.auth.enabled" -}}
  {{- if or (and (.Values.mongodb.enabled) (.Values.mongodb.auth.enabled)) (and (not .Values.mongodb.enabled) (.Values.externalMongoDB.auth.enabled)) -}}
    {{- printf "true" -}}
  {{- else -}}
    {{- printf "false" -}}
  {{- end -}}
{{- end -}}

{{/*
Return the username for the root user to use
*/}}
{{- define "mychart.mongodb.rootUsername" -}}
  {{- if .Values.mongodb.enabled -}}
    {{- printf "%s" (tpl .Values.mongodb.auth.rootUser $) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalMongoDB.auth.rootUser $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the name for the users to create
*/}}
{{- define "mychart.mongodb.usernames" -}}
  {{- if .Values.mongodb.enabled -}}
    {{- printf "%s" (include "mongodb.customUsers" .Subcharts.mongodb) -}}
  {{- else -}}
    {{- $customUsers := list -}}
    {{- range .Values.externalMongoDB.auth.usernames }}
      {{- $customUsers = append $customUsers . }}
    {{- end }}
    {{- printf "%s" (default "" ((join "," $customUsers))) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the passwords for the users to create
*/}}
{{- define "mychart.mongodb.passwords" -}}
  {{- if .Values.mongodb.enabled -}}
    {{- printf "%s" (include "mongodb.customPasswords" .Subcharts.mongodb) -}}
  {{- else -}}
    {{- $customPasswords := list -}}
    {{- range .Values.externalMongoDB.auth.passwords }}
      {{- $customPasswords = append $customPasswords . }}
    {{- end }}
    {{- printf "%s" (default "" ((join "," $customPasswords))) -}}
  {{- end -}}
{{- end -}}

{{/*
Get the name of the secret containing the mongodb password
*/}}
{{- define "mychart.mongodb.secretName" -}}
  {{- if .Values.mongodb.enabled -}}
    {{- printf "%s" (include "mongodb.secretName" .Subcharts.mongodb) -}}
  {{- else if .Values.externalMongoDB.auth.existingSecret -}}
    {{- printf "%s" (tpl .Values.externalMongoDB.auth.existingSecret $) -}}
  {{- else -}}
      {{- printf "%s" (include "mychart.fullname" .) -}}-mongodb
  {{- end -}}
{{- end -}}
