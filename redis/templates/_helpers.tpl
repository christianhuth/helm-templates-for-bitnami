{{/*
Return the hostname of the redis to use
*/}}
{{- define "mychart.redis.hostname" -}}
  {{- if .Values.redis.enabled -}}
    {{- printf "%s-master" (include "common.names.fullname" .Subcharts.redis) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalRedis.hostname $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return redis service port
*/}}
{{- define "mychart.redis.port" -}}
  {{- if .Values.redis.enabled -}}
    {{- printf "%s" (tpl (toString .Values.redis.master.service.ports.redis) $) -}}
  {{- else -}}
    {{- printf "%s" (tpl (toString .Values.externalRedis.port) $) -}}
  {{- end -}}
{{- end -}}

{{/*
Get the user-password key for the redis password
*/}}
{{- define "mychart.redis.auth.enabled" -}}
  {{- if or (and (.Values.redis.enabled) (.Values.redis.auth.enabled)) (and (not .Values.redis.enabled) (.Values.externalRedis.auth.enabled)) -}}
    {{- printf "true" -}}
  {{- else -}}
    {{- printf "false" -}}
  {{- end -}}
{{- end -}}

{{/*
Get the name of the secret containing the redis password
*/}}
{{- define "mychart.redis.secretName" -}}
  {{- if .Values.redis.enabled -}}
    {{- printf "%s" (include "redis.secretName" .Subcharts.redis) -}}
  {{- else if .Values.externalRedis.auth.existingSecret -}}
    {{- printf "%s" (tpl .Values.externalRedis.auth.existingSecret $) -}}
  {{- else -}}
      {{- printf "%s" (include "mychart.fullname" .) -}}-redis
  {{- end -}}
{{- end -}}

{{/*
Get the user-password key for the redis password
*/}}
{{- define "mychart.redis.userPasswordKey" -}}
  {{- if .Values.redis.enabled -}}
    {{- printf "%s" (include "redis.secretPasswordKey" .Subcharts.redis) -}}
  {{- else if .Values.externalRedis.auth.userPasswordKey -}}
    {{- printf "%s" (tpl .Values.externalRedis.auth.userPasswordKey $) -}}
  {{- else -}}
    {{- "password" -}}
  {{- end -}}
{{- end -}}