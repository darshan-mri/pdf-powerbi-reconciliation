"""Automated PDF <-> Power BI validation pipeline.

Modules
-------
pbi_auth      Token acquisition (secret / certificate / managed identity / key vault)
pbi_client    Power BI REST `executeQueries` DAX runner
fetch_report  Config-driven "run DAX -> write ReportExcel" for any report
field_spec    Declarative per-PDF field specifications (schemas/*.json)
extractor     Spec-driven PDF extraction engine
healer        Layout-drift detection + guarded auto-repair of specs
orchestrator  End-to-end runner (extract -> fetch -> compare)
"""

