{{/*
Define the base name of the chart
*/}}
{{- define "serviceexample.name" -}}
serviceexample
{{- end }}

{{/*
Create a full name with release name prefix
Ensures uniqueness across namespaces
*/}}
{{- define "serviceexample.fullname" -}}
{{ printf "%s-%s" .Release.Name (include "serviceexample.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Standard Helm labels
*/}}
{{- define "serviceexample.labels" -}}
helm.sh/chart: {{ include "serviceexample.name" . }}-{{ regexReplaceAll "[^A-Za-z0-9_.-]" .Chart.Version "-" }}
app.kubernetes.io/name: {{ include "serviceexample.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "serviceexample.selectorLabels" -}}
app.kubernetes.io/name: {{ include "serviceexample.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{- define "serviceexample.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- if .Values.serviceAccount.name }}
{{ .Values.serviceAccount.name }}
{{- else }}
{{ printf "%s-%s" .Release.Name .Chart.Name }}
{{- end }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
