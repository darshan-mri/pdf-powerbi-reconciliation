import pandas as pd
from utils.config_util import Config

# ---------- CONFIG ----------
cfg = Config()
billings_path = cfg.get("CM.LEDGER", "BillingsExcel")
credits_path = cfg.get("CM.LEDGER", "CreditsExcel")
output_path = cfg.get("CM.LEDGER", "CombinedExcel")

# ---------- READ EXCEL FILES ----------
df_billings = pd.read_excel(billings_path)
df_credits = pd.read_excel(credits_path)

# ---------- CLEAN COLUMN NAMES ----------
df_billings.columns = df_billings.columns.str.strip()
df_credits.columns = df_credits.columns.str.strip()

# ---------- SPLIT COMMON COLUMNS ----------
def split_building_id_name(val):
    if pd.isna(val):
        return pd.NA, pd.NA
    parts = [p.strip() for p in str(val).split(' - ', 1)]
    return parts[0], parts[1] if len(parts) > 1 else pd.NA

def split_tenant(val):
    if pd.isna(val):
        return pd.NA, pd.NA
    parts = [p.strip() for p in str(val).split(' - ', 1)]
    return parts[0], parts[1] if len(parts) > 1 else (parts[0], pd.NA)

# ---------- TRANSFORM BILLINGS ----------
df_billings[['Building ID', 'Building Name']] = df_billings['Building ID - Name'].apply(lambda x: pd.Series(split_building_id_name(x)))
df_billings[['Occupant', 'Lease Id']] = df_billings['Tenant'].apply(lambda x: pd.Series(split_tenant(x)))

# Drop unnecessary columns
df_billings = df_billings.drop(columns=['Portfolio Name - ID', 'Property ID - Name', 'Building ID - Name'])

# ---------- TRANSFORM CREDITS ----------
df_credits[['Building ID', 'Building Name']] = df_credits['Building ID - Name'].apply(lambda x: pd.Series(split_building_id_name(x)))

# Drop unnecessary columns
df_credits = df_credits.drop(columns=['Portfolio Name - ID', 'Property ID - Name', 'Building ID - Name'])

# ---------- COMBINE DATA ----------
# Merge on common keys
combined = pd.merge(
    df_billings,
    df_credits[['Building ID', 'Suite', 'Manager', 'Total Credits']],
    on=['Building ID', 'Suite', 'Manager'],
    how='outer'
)

# ---------- REORDER COLUMNS ----------
final_columns = [
    'Building ID', 'Building Name', 'Suite', 'Manager',
    'Occupant', 'Lease Id', 'Total Billings', 'Total Credits'
]
for col in final_columns:
    if col not in combined.columns:
        combined[col] = pd.NA

combined = combined[final_columns]

# ---------- SAVE OUTPUT ----------
combined.to_excel(output_path, index=False)
print(f"✅ Combined file saved to: {output_path}")
print(f"Total records: {len(combined)}")
