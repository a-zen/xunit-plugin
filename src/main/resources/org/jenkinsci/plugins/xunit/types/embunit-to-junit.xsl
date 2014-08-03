<?xml version="1.0"?>
<!--
The MIT License (MIT)

Copyright (c) 2014, Gregory Boissinot

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
    <xsl:output method="xml"
                indent="yes"/>
    <xsl:template match="/">
        <testsuites>
            <xsl:apply-templates/>
        </testsuites>
    </xsl:template>
    <xsl:template match="//TestRun/*">
        <testsuite>
            <xsl:attribute name="errors">0</xsl:attribute>
            <xsl:attribute name="failures">
                <xsl:value-of select="//Statistics/Failures"/>
            </xsl:attribute>
            <xsl:attribute name="tests">
                <xsl:value-of select="//Statistics/Tests"/>
            </xsl:attribute>
            <xsl:attribute name="name">
                <xsl:value-of select="name(.)"/>
            </xsl:attribute>
            <properties></properties>
            <system-err></system-err>
            <system-out></system-out>
            <xsl:apply-templates/>
        </testsuite>
    </xsl:template>
    <xsl:template match="//TestRun/Statistics"></xsl:template>
    <xsl:template match="//TestRun/*/Test">
        <testcase>
            <xsl:attribute name="name">
                <xsl:value-of select="Name"/>
            </xsl:attribute>
        </testcase>
    </xsl:template>
    <xsl:template match="//TestRun/*/FailedTest">
        <testcase>
            <xsl:attribute name="name">
                <xsl:value-of select="Name"/>
            </xsl:attribute>
            <failure>
                <xsl:attribute name="message">
                    <xsl:value-of select="Message"/>
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="Location/File"/>
                    <xsl:text>:</xsl:text>
                    <xsl:value-of select="Location/Line"/>
                    <xsl:text>)</xsl:text>
                </xsl:attribute>
            </failure>
        </testcase>
    </xsl:template>
    <xsl:template match="text()|@*"/>
</xsl:stylesheet>
