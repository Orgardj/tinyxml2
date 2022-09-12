Mutation test workflow proof-of-concept for TinyXML-2
======================================================
[![Mutation Workflow](https://github.com/Orgardj/tinyxml2/actions/workflows/full_test.yml/badge.svg)](https://github.com/Orgardj/tinyxml2/actions/workflows/full_test.yml)
[![Commit Mutation Workflow](https://github.com/Orgardj/tinyxml2/actions/workflows/commit_test.yml/badge.svg)](https://github.com/Orgardj/tinyxml2/actions/workflows/commit_test.yml)

This fork adds proof-of-concept (PoF) mutation test CI workflows to the TinyXML-2 project. These were used in the master
thesis [Recommendations for Mutation Testing as Part of a Continuous Integration Pipeline: With a focus on C++](https://hdl.handle.net/20.500.12380/305137)
.
The PoF consists of two workflows; one worfklow using Dextool to mutate git diff of C++ files on new push, and one 
workflow containing two jobs mutating the entire project with Dextool and Mull.

The two workflows can be found under [/.github/workflows](/.github/workflows), Dextool settings under 
[.dextool_mutate.toml](/.dextool_mutate.toml), and Mull settings under [mull.yml](/mull.yml).

Setup
----
Collaborator access is required to run the workflows or add runners. The workflows have been tested on the Ubuntu focal
(20.04) docker image. 

To try the workflows your self:
1. Fork the repository
2. Add a self-hosted runner to run the workflow as explain in
[GitHub Docs: Add self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners)
. GitHub hosted runners can be used but are not recommended, since it would be extremely slow.
3. Add an Artifactory to upload the results to. To do this generate a single config token as explain in 
[JFrog CLI Action Docs: Storing the connection details using single Config Token](https://github.com/marketplace/actions/setup-jfrog-cli#storing-the-connection-details-using-single-config-token)
. Then add a repository secret called `ARTIFACTORY_SECRET` as explained in 
[GitHub Docs: Creating encrypted secrets for a repository](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository)
.
4. The full workflow is started manually in the action tab on GitHub (can be set to run on a timer by uncommenting the 
lines schedule lines). The commit workflow mutating the git diff between the 2 latest commits is triggered on push, on 
pull request or manually.



TinyXML-2
=========

![Build](https://github.com/leethomason/tinyxml2/actions/workflows/test.yml/badge.svg)

![TinyXML-2 Logo](http://www.grinninglizard.com/tinyxml2/TinyXML2_small.png)

TinyXML-2 is a simple, small, efficient, C++ XML parser that can be
easily integrated into other programs.

The master is hosted on github:
https://github.com/leethomason/tinyxml2

The online HTML version of these docs:
http://leethomason.github.io/tinyxml2/

Examples are in the "related pages" tab of the HTML docs.

What it does.
-------------

In brief, TinyXML-2 parses an XML document, and builds from that a
Document Object Model (DOM) that can be read, modified, and saved.

XML stands for "eXtensible Markup Language." It is a general purpose
human and machine readable markup language to describe arbitrary data.
All those random file formats created to store application data can
all be replaced with XML. One parser for everything.

http://en.wikipedia.org/wiki/XML

There are different ways to access and interact with XML data.
TinyXML-2 uses a Document Object Model (DOM), meaning the XML data is parsed
into a C++ objects that can be browsed and manipulated, and then
written to disk or another output stream. You can also construct an XML document
from scratch with C++ objects and write this to disk or another output
stream. You can even use TinyXML-2 to stream XML programmatically from
code without creating a document first.

TinyXML-2 is designed to be easy and fast to learn. It is one header and
one cpp file. Simply add these to your project and off you go.
There is an example file - xmltest.cpp - to get you started.

TinyXML-2 is released under the ZLib license,
so you can use it in open source or commercial code. The details
of the license are at the top of every source file.

TinyXML-2 attempts to be a flexible parser, but with truly correct and
compliant XML output. TinyXML-2 should compile on any reasonably C++
compliant system. It does not rely on exceptions, RTTI, or the STL.

What it doesn't do.
-------------------

TinyXML-2 doesn't parse or use DTDs (Document Type Definitions) or XSLs
(eXtensible Stylesheet Language.) There are other parsers out there
that are much more fully featured. But they are generally bigger and
more difficult to use. If you are working with
browsers or have more complete XML needs, TinyXML-2 is not the parser for you.

TinyXML-1 vs. TinyXML-2
-----------------------

TinyXML-2 long been the focus of all development. It is well tested 
and should be used instead of TinyXML-1.

TinyXML-2 uses a similar API to TinyXML-1 and the same
rich test cases. But the implementation of the parser is completely re-written
to make it more appropriate for use in a game. It uses less memory, is faster,
and uses far fewer memory allocations.

TinyXML-2 has no requirement or support for STL.

Features
--------

### Code Page

TinyXML-2 uses UTF-8 exclusively when interpreting XML. All XML is assumed to
be UTF-8.

Filenames for loading / saving are passed unchanged to the underlying OS.

### Memory Model

An XMLDocument is a C++ object like any other, that can be on the stack, or
new'd and deleted on the heap.

However, any sub-node of the Document, XMLElement, XMLText, etc, can only
be created by calling the appropriate XMLDocument::NewElement, NewText, etc.
method. Although you have pointers to these objects, they are still owned
by the Document. When the Document is deleted, so are all the nodes it contains.

### White Space

#### Whitespace Preservation (default)

Microsoft has an excellent article on white space: http://msdn.microsoft.com/en-us/library/ms256097.aspx

By default, TinyXML-2 preserves white space in a (hopefully) sane way that is almost compliant with the
spec. (TinyXML-1 used a completely different model, much more similar to 'collapse', below.)

As a first step, all newlines / carriage-returns / line-feeds are normalized to a
line-feed character, as required by the XML spec.

White space in text is preserved. For example:

	<element> Hello,  World</element>

The leading space before the "Hello" and the double space after the comma are
preserved. Line-feeds are preserved, as in this example:

	<element> Hello again,
	          World</element>

However, white space between elements is **not** preserved. Although not strictly
compliant, tracking and reporting inter-element space is awkward, and not normally
valuable. TinyXML-2 sees these as the same XML:

	<document>
		<data>1</data>
		<data>2</data>
		<data>3</data>
	</document>

	<document><data>1</data><data>2</data><data>3</data></document>

#### Whitespace Collapse

For some applications, it is preferable to collapse whitespace. Collapsing
whitespace gives you "HTML-like" behavior, which is sometimes more suitable
for hand typed documents.

TinyXML-2 supports this with the 'whitespace' parameter to the XMLDocument constructor.
(The default is to preserve whitespace, as described above.)

However, you may also use COLLAPSE_WHITESPACE, which will:

* Remove leading and trailing whitespace
* Convert newlines and line-feeds into a space character
* Collapse a run of any number of space characters into a single space character

Note that (currently) there is a performance impact for using COLLAPSE_WHITESPACE.
It essentially causes the XML to be parsed twice.

#### Error Reporting

TinyXML-2 reports the line number of any errors in an XML document that
cannot be parsed correctly. In addition, all nodes (elements, declarations,
text, comments etc.) and attributes have a line number recorded as they are parsed.
This allows an application that performs additional validation of the parsed
XML document (e.g. application-implemented DTD validation) to report
line number information for error messages.

### Entities

TinyXML-2 recognizes the pre-defined "character entities", meaning special
characters. Namely:

	&amp;	&
	&lt;	<
	&gt;	>
	&quot;	"
	&apos;	'

These are recognized when the XML document is read, and translated to their
UTF-8 equivalents. For instance, text with the XML of:

	Far &amp; Away

will have the Value() of "Far & Away" when queried from the XMLText object,
and will be written back to the XML stream/file as an ampersand.

Additionally, any character can be specified by its Unicode code point:
The syntax `&#xA0;` or `&#160;` are both to the non-breaking space character.
This is called a 'numeric character reference'. Any numeric character reference
that isn't one of the special entities above, will be read, but written as a
regular code point. The output is correct, but the entity syntax isn't preserved.

### Printing

#### Print to file
You can directly use the convenience function:

	XMLDocument doc;
	...
	doc.SaveFile( "foo.xml" );

Or the XMLPrinter class:

	XMLPrinter printer( fp );
	doc.Print( &printer );

#### Print to memory
Printing to memory is supported by the XMLPrinter.

	XMLPrinter printer;
	doc.Print( &printer );
	// printer.CStr() has a const char* to the XML

#### Print without an XMLDocument

When loading, an XML parser is very useful. However, sometimes
when saving, it just gets in the way. The code is often set up
for streaming, and constructing the DOM is just overhead.

The Printer supports the streaming case. The following code
prints out a trivially simple XML file without ever creating
an XML document.

	XMLPrinter printer( fp );
	printer.OpenElement( "foo" );
	printer.PushAttribute( "foo", "bar" );
	printer.CloseElement();

Examples
--------

#### Load and parse an XML file.

	/* ------ Example 1: Load and parse an XML file. ---- */
	{
		XMLDocument doc;
		doc.LoadFile( "dream.xml" );
	}

#### Lookup information.

	/* ------ Example 2: Lookup information. ---- */
	{
		XMLDocument doc;
		doc.LoadFile( "dream.xml" );

		// Structure of the XML file:
		// - Element "PLAY"      the root Element, which is the
		//                       FirstChildElement of the Document
		// - - Element "TITLE"   child of the root PLAY Element
		// - - - Text            child of the TITLE Element

		// Navigate to the title, using the convenience function,
		// with a dangerous lack of error checking.
		const char* title = doc.FirstChildElement( "PLAY" )->FirstChildElement( "TITLE" )->GetText();
		printf( "Name of play (1): %s\n", title );

		// Text is just another Node to TinyXML-2. The more
		// general way to get to the XMLText:
		XMLText* textNode = doc.FirstChildElement( "PLAY" )->FirstChildElement( "TITLE" )->FirstChild()->ToText();
		title = textNode->Value();
		printf( "Name of play (2): %s\n", title );
	}

Using and Installing
--------------------

There are 2 files in TinyXML-2:
* tinyxml2.cpp
* tinyxml2.h

And additionally a test file:
* xmltest.cpp

Generally speaking, the intent is that you simply include the tinyxml2.cpp and 
tinyxml2.h files in your project and build with your other source code.

There is also a CMake build included. CMake is the general build for TinyXML-2.
Additional build systems are costly to maintain, and tend to bit-rot. 

A Visual Studio project is included, but that is largely for developer convenience,
and is not intended to integrate well with other builds.

Building TinyXML-2 - Using vcpkg
--------------------------------

You can download and install TinyXML-2 using the [vcpkg](https://github.com/Microsoft/vcpkg) dependency manager:

    git clone https://github.com/Microsoft/vcpkg.git
    cd vcpkg
    ./bootstrap-vcpkg.sh
    ./vcpkg integrate install
    ./vcpkg install tinyxml2

The TinyXML-2 port in vcpkg is kept up to date by Microsoft team members and community contributors. If the version is out of date, please [create an issue or pull request](https://github.com/Microsoft/vcpkg) on the vcpkg repository.

Versioning
----------

TinyXML-2 uses semantic versioning. http://semver.org/ Releases are now tagged in github.

Note that the major version will (probably) change fairly rapidly. API changes are fairly
common.

License
-------

TinyXML-2 is released under the zlib license:

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any
damages arising from the use of this software.

Permission is granted to anyone to use this software for any
purpose, including commercial applications, and to alter it and
redistribute it freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must
not claim that you wrote the original software. If you use this
software in a product, an acknowledgment in the product documentation
would be appreciated but is not required.
2. Altered source versions must be plainly marked as such, and
must not be misrepresented as being the original software.
3. This notice may not be removed or altered from any source
distribution.

Contributors
------------

Thanks very much to everyone who sends suggestions, bugs, ideas, and
encouragement. It all helps, and makes this project fun.

The original TinyXML-1 has many contributors, who all deserve thanks
in shaping what is a very successful library. Extra thanks to Yves
Berquin and Andrew Ellerton who were key contributors.

TinyXML-2 grew from that effort. Lee Thomason is the original author
of TinyXML-2 (and TinyXML-1) but TinyXML-2 has been and is being improved
by many contributors.

Thanks to John Mackay at http://john.mackay.rosalilastudio.com for the TinyXML-2 logo!


