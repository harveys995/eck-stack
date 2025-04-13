{{- define "elastic-cluster.nodesets" }}
{{- range .Values.hotNodes }}
- name: {{ .name }}
  count: {{ .count }}
  config:
    node.store.allow_mmap: {{ .config.node.store.allow_mmap | default false }}
  podTemplate:
    spec:
      containers:
        - name: elasticsearch
          resources:
            requests:
              memory: {{ .resources.requests.memory }}
              cpu: {{ .resources.requests.cpu }}
            limits:
              memory: {{ .resources.limits.memory }}
              cpu: {{ .resources.limits.cpu }}
  volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data
      spec:
        accessModes: [{{ .volumeClaim.accessMode | quote }}]
        resources:
          requests:
            storage: {{ .volumeClaim.size }}
{{- end }}
{{- end }}