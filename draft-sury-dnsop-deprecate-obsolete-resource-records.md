%%%
title			= "Deprecating Obsolete DNS Resource Record Types"
abbrev			= "Deprecating RRTYPEs"
updates                 = [1034,1035,3597,4034]
workgroup		= "DNS Operations"
area			= "Operations and Management"
submissiontype	        = "IETF"
ipr			= "trust200902"
date			= 2021-04-14T09:00:00Z
keyword			= [ "DNS", "RRTYPE", "RR" ]

[seriesInfo]
name			= "Internet-Draft"
value			= "draft-sury-dnsop-deprecate-obsolete-resource-records-02"
status			= "standard"

[[author]]
initials		= "O."
surname			= "Sury"
fullname		= "Ondřej Surý"
organization	= "ISC"
 [author.address]
 email			= "ondrej@isc.org"
  [author.address.postal]
  street		= "53 Main St."
  city			= "Newmarket"
  region		= "NH"
  code			= "03824"
  country		= "USA"

[[author]]
initials		= "E."
surname			= "Hunt"
fullname		= "Evan Hunt"
organization	= "ISC"
 [author.address]
 email			= "each@isc.org"
  [author.address.postal]
  street		= "53 Main St."
  city			= "Newmarket"
  region		= "NH"
  code			= "03824"
  country		= "USA"

%%%

.# Abstract

This document deprecates Resource Record (RR) Types that are
either no longer being used for anything meaningful or have
been made obsolete by other RFCs.  This document updates
[@!RFC1034], [@!RFC1035], [@!RFC3597], and [@!RFC4034].

{mainmatter}

# Introduction

[@!RFC1035] and other documents have defined some
Resource Record (RR) Types that are no longer in common use,
some of which have been rendered obsolete by subsequent standards,
but have never been clearly deprecated in the context of the DNS.
In some cases there have been interoperability problems between
DNS implementations that support these types and those that do
not - for example, because of DNS name compression in the
wire format. Continued support for these RR Types imposes a
complexity cost on new implementations for little benefit.

This document formally deprecates such RR Types, allowing
implementations to drop specific support for them.

## Terminology

The key words **MUST**, **MUST NOT**, **REQUIRED**, **SHALL**,
**SHALL NOT**, **SHOULD**, **SHOULD NOT**, **RECOMMENDED**, **MAY**,
and **OPTIONAL** in this document are to be interpreted as described in
[@!RFC2119].

# Deprecating MD, MF, MB, MG, MR, MINFO, MAILA, and MAILB RR Types

The MD, MF, MB, MG, MR, MINFO, MAILA, and MAILB RR Types aren't used in any
existing standards, and this documents deprecates their usage.  The MD, MF,
MB, MG, MR, and MINFO RR Types RDATA contain a domain name that could be
compressed in the RDATA section.

As an update to [@!RFC3597] and [@!RFC4034] this document specifies that
for MD, MF, MB, MG, MR, and MINFO RR types, the canonical form is such that
no downcasing of embedded domain names takes place, and is otherwise
identical to the canonical form specified in [@!RFC4034, section 6.2].

# IANA Considerations {#iana}

This document updates the IANA registry "Domain Name System (DNS)
Parameters" ([@DNS-IANA]) as follows:
	
TYPE   | Value | Meaning    | Reference
-------|-------|------------|--------------
MD     | 3     | DEPRECATED | This document
MF     | 4     | DEPRECATED | This document
MB     | 7     | DEPRECATED | This document
MG     | 8     | DEPRECATED | This document
MR     | 9     | DEPRECATED | This document
MINFO  | 14    | DEPRECATED | This document
Table: Updates to DNS RR Types

# Implementation Considerations {#implementation}

Obsolete types will be flagged as DEPRECATED in the IANA registry, and the
following guidance is given to DNS implementors in the handling of these RR
types:

1. Authoritative DNS Servers SHOULD issue a warning when loading zones that
   contain DEPRECATED RR Types;

1. DNS Servers MUST NOT compress RDATA when rendering DEPRECATED RR Types
   to wire format;

1. Recursive DNS Servers MAY support legacy compression in DEPRECATED RR
   Types for received data for backward compatibility if desired, but
   SHOULD warn if such information is received.  Compressed RDATA in
   DEPRECATED RR Types MUST be uncompressed before sending and they MUST
   NOT be re-transmitted;
    
1. DNS Clients which receive DEPRECATED RR Types MAY interpret them as
   unknown RR types ([@!RFC3597]), and MUST NOT interfere with
   their transmission;
    
1. DNSSEC Validators and Signers SHOULD treat RDATA for DEPRECATED RR Types
   as opaque with respect to canonical RR ordering and deduplication;

1. DEPRECATED RR Types MUST NOT be treated as a known type with respect to
   the wire protocol.
    
# Security Considerations {#security}

This document has no security considerations.

# Operational Considerations {#operation}

The varying states of implementation of MD, MF, MB, MG, MR, and MINFO RR
Types have already caused operational problems between DNS implementations
that do implement the aforementioned types and those that don't, because of
mismatched handling of DNS compression on the wire.  This document aims to
rectify the situation by encouraging removal of support for all these RR
types in all DNS implementations.  This should not cause signficant
operational problems because these records are not in wide use on the
Internet. [COMMENT: Some data?]

# Acknowledgments {#ack}

The authors would like to thank Peter van Dijk for prompting us to write
the draft, Daniel Salzman for reviewing the document, and Michael
Casadevall for contributions to the Implementation Considerations section.

{backmatter}

<reference anchor="DNS-IANA" target="https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml">
  <front>
    <title>Domain Name System (DNS) Parameters</title>
    <author initials="" surname="" fullname="">
      <organization />
    </author>
    <date />
  </front>
</reference>
