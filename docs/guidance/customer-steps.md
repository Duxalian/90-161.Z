# Customer guidance, one step at a time (draft for PFM content approval)

Status: draft by Claude, 12 Nov 26. Not approved. The PFM approves the wording (AGENTS.md: content approval). After approval, each row becomes one PFM Guidance row (decision 12A): Guidance Key, Audience, Screen Order, Heading (Title), Instructions, DAFMAN Reference, Done When. The app shows one row per screen and moves on only when "Done When" is met.
Source: DAFMAN 90-161 (ref/dafman90-161.txt) and the paths in docs/process-model.md ("New publication request" N1-N11, stages 0-12, "Special review out of cycle" S1-S7). Wording: plain words for a first-time action officer (DAFMAN 1.2.4; style rule 7); terms as DAFMAN spells them (style rule 1).

Audience values: AO (action officer, the customer), Endorser, Certifying Official, Approving Official, PFM.

## 1. Start

| Key | Audience | Order | Heading | Instructions | DAFMAN | Done When |
|---|---|---|---|---|---|---|
| START-01 | AO | 1 | What Do You Need to Do? | Pick one: 1) Create a new publication. 2) Change a publication your office owns. 3) Answer a review task from the PFM. 4) Suggest a change to a publication another office owns. 5) Remove a publication. 6) Give a publication to another office. 7) Create or change a form. Not sure? Pick 1 or 2; the next screens check your choice. | 3.1, 1.1.4 | One choice saved |
| START-02 | AO | 2 | Are You the Action Officer? | Only the office that owns a publication (the office of primary responsibility, OPR) can create or change it. The OPR names one action officer (AO) for each publication. If your office did not name you, the PFM asks your office to name its AO first. You can still save your request. | 2.7, 2.7.2, 2.8 | Office picked; AO named or AO request sent |

## 2. Publication types: which one do you need?

Shown as a help panel on NEW-05 and CHG-01. Directive = people must comply; non-directive = information only.

| Key | Audience | Order | Heading | Instructions | DAFMAN | Done When |
|---|---|---|---|---|---|---|
| TYPE-01 | AO | 1 | Instruction | Tells people what to do. Use it for wing rules that apply beyond one office. It can implement higher-headquarters guidance in more detail. Example: a wing instruction on base access procedures. | 1.1.2.1, Table A11.1 item 4 | - |
| TYPE-02 | AO | 2 | Manual | Tells people how to do something: detailed steps or technical procedures, usually an extension of an instruction. A wing manual does not implement a higher-headquarters manual; use a supplement for that. | Table A11.1 item 5 | - |
| TYPE-03 | AO | 3 | Supplement | Adds wing material to a higher-headquarters instruction or manual. It keeps the parent's paragraph numbers and has only the wing's added material (a wing supplement is always standalone). Its number is the parent number plus "_<unit>SUP". Use it when the subject is already in a higher-headquarters instruction or manual. You cannot supplement a policy directive, policy memorandum, guidance memorandum, mission directive, operating instruction or DoD issuance, or a publication that says it may not be supplemented. | 1.1.3.5, 1.1.3.5.2, 4.3.8.1, 4.7.3.4, Table A11.1 item 4 | - |
| TYPE-04 | AO | 4 | Operating Instruction | Procedures inside one function at the lowest level (for example one group staff or one section). It applies only to that function. If subordinate squadrons must comply, use an instruction or manual instead. It cannot be supplemented. | Table A11.1 item 8, 4.7.3.4.7 | - |
| TYPE-05 | AO | 5 | Instructional Checklist | Step-by-step help for a task, referenced in a named instruction or manual. It does not collect data and is not an inspection checklist; to collect data, use a form. | Table A11.1 item 6 | - |
| TYPE-06 | AO | 6 | Guidance Memorandum | Fast guidance only when waiting would risk life, safety, property or mission. Only one per publication at a time. Needs legal review, both signatures and a written reason for the urgency. It expires 1 year after its effective date; a new publication, interim change or rewrite must replace it. A wing guidance memorandum changes only wing publications. | 7.9.1, 5.1.7, Table A11.1 item 7, Table A5.1 note 1 | - |
| TYPE-07 | AO | 7 | Information Only (Non-Directive) | Pamphlets and handbooks give information and may not require anything. 90-161.Z handles directive publications only; contact the PFM for these. | 1.1.2.2, Table A11.2 | - |

## 3. New publication (no publication exists yet)

| Key | Audience | Order | Heading | Instructions | DAFMAN | Done When |
|---|---|---|---|---|---|---|
| NEW-01 | AO | 1 | Must People Comply? | If people must follow it, it is a directive publication: continue. If it is information only, it is a pamphlet or handbook (TYPE-07): stop and contact the PFM. | 3.1.1, 1.1.2 | Answer saved |
| NEW-02 | AO | 2 | Check the Wing's Publications | Search the wing's publications list (PFM Product Index) by subject words. If a wing publication already covers your subject, change that one instead (go to CHG-01). Two publications on one subject cause conflicts. | 3.1.2 | Search done; "none found" or a product picked |
| NEW-03 | AO | 3 | Check Higher Headquarters | Search e-Publishing (departmental and ANG publications) for your subject. If a higher-headquarters instruction or manual covers it, you normally write a wing supplement to it (TYPE-03). Enter the higher-headquarters number you found. | 3.1.2, 3.1.8, 1.1.3.6.5 | Search done; number entered or "none found" |
| NEW-04 | AO | 4 | No Higher-Headquarters Instruction or Manual? | If only a policy directive exists, the wing may write its own instruction or manual to implement it. The app marks it: when a departmental instruction or manual comes out later, your office must revise or rescind the wing publication. | 1.1.3.6.4 | Answer saved |
| NEW-05 | AO | 5 | Pick the Type | Use the type panel (TYPE-01 to TYPE-06). The app warns you if the type does not fit your earlier answers. | 3.1.6, Table A11.1 | Type picked |
| NEW-06 | AO | 6 | Why Is It Needed? | In plain words: what it implements (higher-headquarters number), what problem it solves, and the risk if it is not issued. | 3.1.4, 3.1.8, 4.4 | Text entered |
| NEW-07 | AO | 7 | Pick the Subject Series | Pick the series that matches the subject (for example 33 Communications and Information). Series 1 is only for the Secretary of the Air Force, Chief of Staff of the Air Force and Chief of Space Operations. | 4.3.1, Table A2.1 | Series picked |
| NEW-08 | AO | 8 | Your Number | The PFM gives the number. You do not pick it. Wing numbers are consecutive in the series with at least 3 digits; a supplement uses the parent number plus "_<unit>SUP". You get an e-mail when the number is ready. | 4.3.8, 4.3.8.1 | PFM assigned and approved the number |
| NEW-09 | AO | 9 | Do You Need a Form? | First check for a higher-headquarters form you can use (adopt). A new form must not duplicate an existing one. The PFM gives new form numbers. A new form is posted together with its publication. | 8.1.3, 8.3, 8.6.1, 8.7 | "No form", "adopt" or "new form" saved |
| NEW-10 | AO | 10 | Who Signs? | Name your certifying official (normally one level above your office) and your approving official. If they are the same person, the approving official may sign as both. | 5.6.3.2, 5.7 | Both named |

Then the common stages (section 5).

## 4. Change a publication your office owns

| Key | Audience | Order | Heading | Instructions | DAFMAN | Done When |
|---|---|---|---|---|---|---|
| CHG-01 | AO | 1 | What Kind of Change? | Answer the questions; the app picks the action: 1) Only office symbols, e-mail addresses or web links change: Administrative Change. 2) Some paragraphs change: Interim Change. 3) Much of it changes, or it is old: Rewrite. 4) It must change now because of risk to life, safety, property or mission: Guidance Memorandum. 5) Nothing needs to change: Certify Current. 6) It is no longer needed: Rescind. 7) Another office should own it: Transfer. 8) A typing or processing error after posting: tell the PFM (Corrective Action). | 7.8.2, 7.7.1, 7.6, 7.9.1, 7.5, 7.11.5, 7.10, Glossary | Action picked |
| CHG-AC-01 | AO | 2 | Administrative Change | Only office symbols, e-mail addresses and web links. List each change in one document (for example: "Change AF/XX to AF/YY throughout"). No coordination and no certifying official. The approving official signs the DAF Form 673. Other small changes need a waiver from the PFM. | 7.8.1-7.8.10 | Signed 673 and change list uploaded |
| CHG-IC-01 | AO | 2 | Interim Change | Start from the current publication (the PFM sends the Word file). Add a summary of changes. Mark each changed paragraph with a margin bar (a left border); do not use asterisks or "(Added)". Full coordination, legal review and both signatures apply. The PFM numbers it IC-1, IC-2 and so on. It must also take in any active guidance memorandum or administrative change. | 7.7.3-7.7.9, 4.3.9, 7.7.7, 7.8.4 | Draft uploaded |
| CHG-RW-01 | AO | 2 | Rewrite | Write the whole publication again in the current format. Full coordination, legal review and both signatures apply. It must take in any active guidance memorandum or administrative change. | 7.6, 7.7.7, 7.8.4 | Draft uploaded |
| CHG-GM-01 | AO | 2 | Guidance Memorandum | Only for urgent risk (TYPE-06). Write why it cannot wait. Legal review and both signatures. It expires in 1 year; plan the interim change or rewrite now. An interim change cannot change a guidance memorandum: reissue the whole memorandum instead. | 7.9, 5.1.7, 7.7.6 | Reason and draft uploaded |
| CHG-CC-01 | AO | 2 | Certify Current | No change is needed. Fill in a DAF Form 399; your office and the approving official sign it. No coordination. The publication must still meet the current content rules. The PFM marks it "Certified Current on" with the date. | 7.5.1, 7.5.2 | Signed 399 uploaded |
| CHG-RS-01 | AO | 2 | Rescind | Before you rescind, move any rule people must still follow into another publication (for example with a guidance memorandum). Forms the publication prescribes are cancelled unless you first link them to another publication. Coordination, legal review and both signatures apply. | 7.11.5, Figure A5.1, 8.12.1 | Draft 673 uploaded |
| CHG-TR-01 | AO | 2 | Transfer | First your approving official gets the new office's approving official to agree. Then: your approving official signs as certifier, the new approving official signs as approver. If only the owning office changes inside the same organization, use Change OPR (no outside coordination). | 7.10.1-7.10.7 | Agreement and 673 uploaded |
| CHG-847-01 | AO | 1 | Suggest a Change to Someone Else's Publication | You cannot change it yourself. Fill in a DAF Form 847 with the paragraph, your proposed text and the reason. Each level of your chain (squadron, group, wing) concurs before it goes to the owning office. For higher-headquarters publications it goes up your functional chain to the ANG functional office at NGB. The PFM gives it a tracking number. | 7.4.5, Attachment 6 | 847 uploaded |

## 5. Common stages (all actions that need them)

| Key | Audience | Order | Heading | Instructions | DAFMAN | Done When |
|---|---|---|---|---|---|---|
| STG-DRAFT | AO | 20 | Write the Draft | Write in Word with your subject matter experts. Plain words, short sentences, "must" for requirements. The draft checklist shows what a complete draft has (opening paragraph, roles, attachments). Do not set fonts or spacing; the PFM's tool formats it. | 3.2, 4.2, 1.2.4 | Draft uploaded |
| STG-CONTENT | AO | 21 | Check What the Draft Requires | A publication must not: restrict delegation without a legal or other reason; set a minimum grade without a legal reason; make a duty an "additional duty"; create work or cost higher headquarters has not approved; contain partisan or inappropriate material; overload small units. Waiver authority must be at the lowest level. | 1.2.9-1.2.17 | Each item checked |
| STG-FORMAT | AO | 22 | The PFM Formats Your Draft | The PFM runs your draft through the formatting tool and sends it back. Check the content only. | 6.1.2, 3.1.7 | PFM marks it ready |
| STG-PRIV | AO | 23 | Privacy Monitor Review | Send the draft to your unit privacy monitor before formal coordination. | 2.8.1, Table A3.1 note 2 | Privacy monitor responded |
| STG-COORD-01 | AO | 24 | Choose Your Coordinators | Mandatory offices are already listed (legal last, CIO, PFM, FOIA, records). Add every office with a functional interest; the app suggests offices from your answers (Table A3.2). Coordinate with the local reserve unit if the publication applies to it. | 5.1.3, 1.9, Tables A3.1, A3.2 | List saved |
| STG-COORD-02 | AO | 25 | Formal Coordination | The package (draft, comment matrix, DAF Form 673) goes to all coordinators at once. They have 15 business days. Answer every comment in the comment matrix. A nonconcur must be resolved before approval; if it cannot be, write an impasse memo to the approving official. | 5.1, 5.1.5, 5.2, 5.5 | All answered or N/A; comments adjudicated |
| STG-LEGAL | AO | 26 | Legal Review | Legal reviews last, after all other coordination. Legal must answer; "no response" is not allowed for legal. | 5.1.8.2, 5.4.3 | Legal responded |
| STG-CERT | AO | 27 | Certification | Send the DAF Form 673 to your certifying official. Upload it signed. | 5.6 | Signed 673 uploaded |
| STG-APPR | AO | 28 | Approval | Send the DAF Form 673 to your approving official. Upload it signed. Any open nonconcur needs an impasse memo. | 5.7, 5.5.2 | Signed 673 uploaded |
| STG-SUBMIT | AO | 29 | Send the Final Package | Upload the signed 673 (or 399), the final Word draft and figure files. | 6.6.1 | Package submitted |
| STG-POST | AO | 30 | Posted | The PFM posts it on the wing site and e-mails you the link and effective date. The effective date can be later than posting, but never earlier. | 6.4.1, 6.6.2, 3.7.5 | You received the notice |

## 6. Endorsers and reviews

| Key | Audience | Order | Heading | Instructions | DAFMAN | Done When |
|---|---|---|---|---|---|---|
| END-01 | Endorser | 1 | Your Coordination | Read the draft. Pick one answer for the whole publication: Concur, Concur With Comment, Nonconcur or No Comment. Put comments in the comment matrix and mark each as administrative, substantive or critical. A critical comment means Nonconcur. Need more time? Ask before the due date with a reason and a new date. | 5.3, 5.4, 5.2.1 | Answer saved |
| REV-01 | AO | 1 | Review Task | The PFM asks you to review a publication (every 4 years, or out of cycle when a commander or a change requires it). You have at least 30 days. Answer on a DAF Form 399: Certify Current, Requires Revision, Requires Transfer, Is Obsolete or Other. Review its forms too. Any answer other than Certify Current: start that action within 180 days. No answer: the PFM may rescind the publication. | 7.4.2-7.4.4, 8.11.3.2 | Signed 399 uploaded |
