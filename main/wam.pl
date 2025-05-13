=pod
Copyright (c) 2025, London Sheard

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
=cut

#!/usr/bin/perl

use strict;

my ($arg1, $arg2) = @ARGV;

#check if arguments is less than 2, if so skeleton or help
if (@ARGV < 2) { 
    if ($arg1 eq "help") {
        print "'wam skeleton {folder}' to build skeleton\n";
        print "'wam {folder} {folder.war}' to compile to .war\n";
        exit;
    } else {
        if ($arg1 eq "skeleton") {
        print "Missing output folder name\n";
        exit 1;
    }
        print "Invalid argument(s): @ARGV\n";
        print "'wam help' for help\n";
        exit 1;
    }
}

if ($arg1 eq "skeleton") {
    my $build = "git clone https://github.com/LS554/webapptemplate.git && rm -rf webapptemplate/.git && rm webapptemplate/WEB-INF/classes/.gitignore && rm webapptemplate/WEB-INF/lib/.gitignore && mv webapptemplate $arg2";
    my $cleanup = "rm -rf '$arg2/.git/'";
    system($build) == 0
        or die "Failed to clone into webapptemplate: $! is git installed?";
        exit 1;
}

# Check if export name ends with .war
unless ($arg2 =~ /\.war$/) {
    print "Missing file extension: *.war\n";
    exit 1;
}

# Check if folder exists
unless (-d $arg1) {
    print "Error: Folder '$arg1' does not exist.\n";
    exit 1;
}

# Run the jar command
my $jar_path = "/usr/lib/jvm/java-21-openjdk-amd64/bin/jar";
my $cmd = "$jar_path -cvf \"$arg2\" -C \"$arg1\" .";

system($cmd) == 0
    or die "Failed to run jar command: $! is java installed?";
