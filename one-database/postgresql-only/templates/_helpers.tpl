{{/*
Return the hostname of the postgresql to use
*/}}
{{- define "mychart.postgresql.hostname" -}}
  {{- if .Values.postgresql.enabled -}}
    {{- printf "%s" (include "postgresql.primary.fullname" .Subcharts.postgresql) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalPostgresql.hostname $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return postgresql service port
*/}}
{{- define "mychart.postgresql.port" -}}
  {{- if .Values.postgresql.enabled -}}
    {{- printf "%s" (include "postgresql.service.port" .Subcharts.postgresql) -}}
  {{- else -}}
    {{- printf "%s" (tpl (toString .Values.externalPostgresql.port) $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the name for the database to use
*/}}
{{- define "mychart.postgresql.database" -}}
  {{- if .Values.postgresql.enabled -}}
    {{- printf "%s" (include "postgresql.database" .Subcharts.postgresql) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalPostgresql.auth.database $) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the name for the user to use
*/}}
{{- define "mychart.postgresql.username" -}}
  {{- if .Values.postgresql.enabled -}}
    {{- printf "%s" (include "postgresql.username" .Subcharts.postgresql) -}}
  {{- else -}}
    {{- printf "%s" (tpl .Values.externalPostgresql.auth.username $) -}}
  {{- end -}}
{{- end -}}

{{/*
Get the name of the secret containing the postgresql user password
*/}}
{{- define "mychart.postgresql.secretName" -}}
  {{- if .Values.postgresql.enabled -}}
    {{- printf "%s" (include "postgresql.secretName" .Subcharts.postgresql) -}}
  {{- else if .Values.externalPostgresql.auth.existingSecret -}}
    {{- printf "%s" (tpl .Values.externalPostgresql.auth.existingSecret $) -}}
  {{- else -}}
      {{- printf "%s" (include "mychart.fullname" .) -}}-postgresql
  {{- end -}}
{{- end -}}

{{/*
Get the user-password key for the postgresql user password
*/}}
{{- define "mychart.postgresql.userPasswordKey" -}}
  {{- if .Values.postgresql.enabled -}}
    {{- printf "%s" (include "postgresql.userPasswordKey" .Subcharts.postgresql) -}}
  {{- else if .Values.externalPostgresql.auth.userPasswordKey -}}
    {{- printf "%s" (tpl .Values.externalPostgresql.auth.userPasswordKey $) -}}
  {{- else -}}
    {{- "password" -}}
  {{- end -}}
{{- end -}}