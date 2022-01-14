# Per- and polyfluoroalkyl substances suspect list

To access the most up-to-date version go to [https://data.nist.gov/od/id/mds2-2387](https://data.nist.gov/od/id/mds2-2387) and download the file called 'PFAS Suspect List.xlsx'

## Use of list

The list is intended to be used to screen high-resolution mass spectrometry data for possible known per- and polyfluoroalkyl substances (PFAS).

For each compound listed, the following properties are provided:

| Property   |   Description    |
| ---------- | ---------------- |
| NAME       | User input name of the compound, there is no formal rules for nomenclature |
| INCHI      | IUPAC International Chemical Identifier (InChI) notation for the chemical structure |
| SOURCE     | Citation for the source of the compound structural information |
| SOURCE_TYPE | Type of citation used for the source of the compound structural information |
| ADDITIONAL | An aggregation of all additional columns provided by the input user |
| SMILES     | Simplified molecular-input line-entry system (SMILES) structural notation |
| INCHIKEY   | Hashed form of the InChI structure |
| FIXEDHINCHI | InChI Key notation with fixed hydrogen layer (non-standard) |
| LOCAL_POS  | Number of atoms with a fixed positive charge state |
| LOCAL_NEG  | Number of atoms with a fixed negative charge state |
| FORMULA    | Elemental formula of the structure |
| FIXEDMASS  | Exact mass of the fixed elemental formula, including charge state |
| NETCHARGE  | Formal charge of the structure |
| DTXSID     | EPA DSS Tox Substance Identifier |
| DTXCID     | EPA DSS Tox Compound Identifier |
| CASRN      | Chemical Abstracts Service registry number |
| PUBCHEMID  | PubChem ID for the InChI Key structure, multiple IDs are separated by semi-colons (;) |
| INSPECTEDBY | The initials of the user that manually evaluated the structure and the associated data, NA indicates that the structure has not been manually evaluated |

## Format of input file
Input files must be Microsoft Excel (*.xlsx) format with the minimum headers in the first row (case sensitive): NAME, INCHI, SOURCE, SOURCE_TYPE
These headers are defined as:

_NAME_ - Name of the compound

_INCHI_ - InChI structural notation of the compound

_SOURCE_ - Specific citation for the compound, DOI or website is preferred (do not use "Author et al."-type citations). More than one can be separated by a semi-colon (;)

_SOURCE_TYPE_ - type of citation listed above, see "Additional Information" for more

Additional headers will be lumped into an "ADDITIONAL" Column for easier searching.
Blank values for any additional headers are accepted, empty cells for NAME, INCHI, SOURCE, SOURCE_TYPE will lead to an error.

An example file for providing new compounds is included in this directory as a file named "example_input.xlsx"

Currently, input files can be emailed to pfas@nist.gov. You will receive a verification email once the data is loaded onto the suspect list, you may be requested to provide review of flagged entries.

## Additional information

**Source Types:**

| Value |   Type |		Definition |
| ----- | -------| --------------- |
| C |	Curated	|	Compound structure, name, and other properties have been evaluated through a documented process for a database or library. |
| E |	Empirical |	Structure has been measured and derived empirically through a peer-reviewed process. |
| I |	Inferred |	Structure that is a homolog (differing in CF2 chain lengths) of an empirically-derived structure, but has not been observed empirically. |
| S |	In Silico |	Structure has been predicted through documented in silico processes, but has not been observed empirically. |
| D |	Documented |	Structure has been reported in documentation (e.g., patent, safety data sheet), but has not been observed empirically. |
| L | Limited | Limited information to support structure, only a formula exists |


## NIST Disclaimer

The data provided in the PFAS Suspect List has been aggregated from public sources and users, including peer-reviewed literature, patent literature, and public websites. Therefore, the quality and accuracy of the compound names, structures, and other properties has not been validated. The National Institute of Standards & Technology does not endorse or provide any assessment of confidence with the information provided.

Certain commercial equipment, instruments, software, or materials are identified in this documentation in order to specify the experimental procedure adequately. Such identification is not intended to imply recommendation or endorsement by the National Institute of Standards and Technology, nor is it intended to imply that the materials or equipment identified are necessarily the best available for the purpose.

## NIST License Statement

This data/work was created by employees of the National Institute of Standards and Technology (NIST), an agency of the Federal Government. Pursuant to title 17 United States Code Section 105, works of NIST employees are not subject to copyright protection in the United States.  This data/work may be subject to foreign copyright.

The data/work is provided by NIST as a public service and is expressly provided “AS IS.” NIST MAKES NO WARRANTY OF ANY KIND, EXPRESS, IMPLIED OR STATUTORY, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTY OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT AND DATA ACCURACY. NIST does not warrant or make any representations regarding the use of the data or the results thereof, including but not limited to the correctness, accuracy, reliability or usefulness of the data. NIST SHALL NOT BE LIABLE AND YOU HEREBY RELEASE NIST FROM LIABILITY FOR ANY INDIRECT, CONSEQUENTIAL, SPECIAL, OR INCIDENTAL DAMAGES (INCLUDING DAMAGES FOR LOSS OF BUSINESS PROFITS, BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, AND THE LIKE), WHETHER ARISING IN TORT, CONTRACT, OR OTHERWISE, ARISING FROM OR RELATING TO THE DATA (OR THE USE OF OR INABILITY TO USE THIS DATA), EVEN IF NIST HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

To the extent that NIST may hold copyright in countries other than the United States, you are hereby granted the non-exclusive irrevocable and unconditional right to print, publish, prepare derivative works and distribute the NIST data, in any medium, or authorize others to do so on your behalf, on a royalty-free basis throughout the world.

You may improve, modify, and create derivative works of the data or any portion of the data, and you may copy and distribute such modifications or works. Modified works should carry a notice stating that you changed the data and should note the date and nature of any such change. Please explicitly acknowledge the National Institute of Standards and Technology as the source of the data:  Data citation recommendations are provided at https://www.nist.gov/open/license.

Permission to use this data is contingent upon your acceptance of the terms of this agreement and upon your providing appropriate acknowledgments of NIST’s creation of the data/work.

## Funding Source

The data included in this repository has been funded, in part, by the Department of Defense's Strategic Environmental Research and Development Program (SERDP), project number ER20-1056.