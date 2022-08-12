class ScholarshipModel {
  final String name, amount, eligiblity, income, url;

  ScholarshipModel(
      this.name, this.amount, this.eligiblity, this.income, this.url);

  static final scholarshipData = [
    // ScholarshipModel(name, amount, eligiblity, income, url),
    //
    // ScholarshipModel("E GRANTZ", "50k per annum", "SC/ ST/ OBC/ OEC",
    //     "No Limit", "https://google.com"),
    ScholarshipModel(
        "CENTRAL SECTOR",
        "10k per year for 3 years\n20k per year for last year",
        "80% marks in 12th exam",
        "Below 8 lakh",
        "https://scholarships.gov.in/"),
    ScholarshipModel("POSTMETRIC", "Around 15k per year", "50% in plus two",
        "Below 2 lakh", "https://scholarships.gov.in/"),
    ScholarshipModel("MCM", "Around 50k per year", "Minority Communities",
        "Below 2.5 lakh", "https://scholarships.gov.in/"),
    ScholarshipModel(
        "National Fellowship",
        "Around 50k per year",
        "Scheduled tribe",
        "6 lakh per annum",
        "https://tribal.nic.in/?aspxerrorpath=/Schemes.aspx"),
    ScholarshipModel(
        "ANANDAM SENAPATHI",
        "Max 54k per year",
        "For first year students",
        "Below 3 lakh",
        "https://srk.vidyadhan.org/register"),
    ScholarshipModel(
        "FEDERAL BANK \nHORMIS",
        "Maximum of 1 lakh per year",
        "Native of Kerala/TN/MH/GJ\nAdmission in 2021-22",
        "Below 3 lakh",
        "https://www.federalbank.co.in/corporate-social-responsibility"),
    ScholarshipModel(
        "AICTE PRAGATI",
        "50k per annum",
        "Girls admitted to 1st year.",
        "Below 8 lakh",
        "https://scholarships.gov.in/"),
    ScholarshipModel(
        "E GRANTZ",
        "50k per annum",
        "SC/ ST/ OBC/ OEC",
        "SC/ST/SEBC - No Limit\nOthers - 1 lakh",
        "https://www.egrantz.kerala.gov.in/"),
    ScholarshipModel(
        "AICTE SAKSHAM \nFOR DISABLED",
        "Around 50k per year",
        "Disablity more than 40%",
        "Below 8 lakh",
        "https://scholarships.gov.in/"),
    ScholarshipModel(
        "CH MUHAMMED KOYA",
        "7k per year\nHostel stipend 13k per year",
        "Girls of muslim community and\nlatin converted christian community",
        "Below 8 lakh",
        "http://dcescholarship.kerala.gov.in/dce/he_ma/he_maindx.php"),
    ScholarshipModel(
        "SUVARNA JUBILEE MERIT",
        "10k per annum",
        "BPL, Above 50% in qualifying exam.",
        "Below 5 lash",
        "https://www.dcescholarship.kerala.gov.in/dce/he_ma/he_maindx.php"),
    ScholarshipModel(
        "SNEHAPOORVAM",
        "1k per month",
        "Orphan student,\nResident of kerala",
        "For APL\nBelow 20k - Rural areas\nBelow22,375 - Urban areas",
        "https://socialsecuritymission.gov.in/"),
    ScholarshipModel(
        "STATE MERIT",
        "1250 per annum",
        "50% or above in qualifying exam",
        "Befor 1 lakh",
        "https://www.dcescholarship.kerala.gov.in/dce/he_ma/he_maindx.php"),
    ScholarshipModel("VIDYA SAMUNNATHI", "Upto 50k per annum",
        "Non-reserver categories", "Before 2 lakh", "https://www.kswcfc.org/"),
    ScholarshipModel(
        "KEEP SMILING INDIA",
        "Around 30k per 3 years",
        "60% in plus 2",
        "Below 5 lakh",
        "https://www.buddy4study.com/page/keep-india-smiling-foundational-scholarship-programme"),
    ScholarshipModel(
        "SIEMENS",
        "Around 50k",
        "SSC - Minimum 60%\nHSC - Minimum 50%\nPCM - 60% aggregate",
        "Below 2 lakh",
        "https://new.siemens.com/in/en/company/sustainability/corporate-citizenship/siemens-scholarship-program.html")
  ];
}
