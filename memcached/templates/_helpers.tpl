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
Return the hostname of the memcached to use
*/}}
{{- define "mychart.memcached.hostname" -}}
  {{- if .Values.memcached.enabled -}}
    {{- printf "%s" (include "common.names.fullname" .Subcharts.memcached) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalMemcached.hostname $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return memcached service port
*/}}
{{- define "mychart.memcached.port" -}}
  {{- if .Values.memcached.enabled -}}
    {{- printf "%s" (tpl (toString .Values.memcached.service.ports.memcached) $) -}}
  {{- else -}}
    {{- printf "%s" (tpl (toString .Values.externalMemcached.port) $) -}}
  {{- end -}}
{{- end -}}

{{/*
Get the user-password key for the memcached password
*/}}
{{- define "mychart.memcached.auth.enabled" -}}
  {{- if or (and (.Values.memcached.enabled) (.Values.memcached.auth.enabled)) (and (not .Values.memcached.enabled) (.Values.externalMemcached.auth.enabled)) -}}
    {{- printf "true" -}}
  {{- else -}}
    {{- printf "false" -}}
  {{- end -}}
{{- end -}}

{{/*
Return the name for the user to use
*/}}
{{- define "mychart.memcached.username" -}}
  {{- if .Values.memcached.enabled -}}
    {{- printf "%s" (tpl .Values.memcached.auth.username $) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalMemcached.auth.username $) -}}
  {{- end -}}
{{- end -}}

{{/*
Get the name of the secret containing the memcached password
*/}}
{{- define "mychart.memcached.secretName" -}}
  {{- if .Values.memcached.enabled -}}
    {{- printf "%s" (include "memcached.secretPasswordName" .Subcharts.memcached) -}}
  {{- else if .Values.externalMemcached.auth.existingSecret -}}
    {{- printf "%s" (tpl .Values.externalMemcached.auth.existingSecret $) -}}
  {{- else -}}
      {{- printf "%s" (include "mychart.fullname" .) -}}-memcached
  {{- end -}}
{{- end -}}

{{/*
Get the user-password key for the memcached password
*/}}
{{- define "mychart.memcached.userPasswordKey" -}}
  {{- if .Values.memcached.enabled -}}
    {{- "memcached-password" -}}
  {{- else if .Values.externalMemcached.auth.userPasswordKey -}}
    {{- printf "%s" (tpl .Values.externalMemcached.auth.userPasswordKey $) -}}
  {{- else -}}
    {{- "password" -}}
  {{- end -}}
{{- end -}}
