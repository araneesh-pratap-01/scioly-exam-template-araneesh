# scioly-test-base

LaTeX files and custom document class for Science Olympiad exam writing, originally developed by me (Araneesh Pratap) for my own use, released since it might be useful to other event supervisors.

## How to use

1. Copy the files for your own use (use Git if you want, otherwise there is a zip file in the attached artifacts for the [latest release](https://github.com/araneesh-pratap-01/scioly-exam-template-araneesh/releases)).
2. Have a TeX distribution set up. It will probably also work with Overleaf if you want (you may need to configure the compilation engine, at least), though I haven't tried it myself as I do my work locally.
3. Swap out the logo in `./images/` if you want to use a tournament-specific logo.
4. Open `./data/exam-scioly-araneesh-data.sty`, fill out the tournament- and event-specific info, and increase the number of sections if needed. Probably also rename the various `.tex` files in the main directory.
5. Open `./data/exam-content.txt` and enter the exam content - questions, answers, question-level formatting instructions, and such. The data format is described in a later section of this readme.
6. Place images for the image sheet in `./images/`. For Git users, the `.gitignore` in that directory is set to ignore image files aside from the logo, naturally you can turn that off if you want though you'd want to be careful with handling image binaries in that case, especially if you're using Github or some other such third-party remote host.
7. Format images into the image sheet file `ExamTemplate_ImageSheet.tex` directly.
8. Adjust instructions in the test packet file `ExamTemplate_TestPacket.tex` file directly - the provided instruction set is just an example, which often serves my needs but regularly needs adjustments for specific scenarios.
9. If you want images on the answer sheet and key, you'll have to input those directly, at the end of the auto-generated exam contents. This was a tradeoff to avoid complex formatting interactions, since it's not that big of a feature to lose out on anyway.
10. Build the project and verify that the output is as expected. See the relevant section below.

## Building

Compile the `.tex` files in the main directory, the engine should automatically pick up the class and package files, and ingest the exam content to populate the outputs.

I use LuaLaTeX as the engine, namely `LuaHBTeX, Version 1.14.0 (TeX Live 2022/dev/Debian)` but pretty much any reasonably recent version should work as TeX tooling tends to be very stable. I haven't tried other engines and I could not tell you anything about how interoperable they are.

I've included a minimalistic build script `./build.sh` as an example, using Latexmk as the build tool (you can use `latexmk -C` to clean the main directory if you want, I personally would rather keep the faster compilation times in exchange for a bit of clutter).

## Data Format

`./data/exam-context.txt` is a simple data file that handles the primary exam content for the Test Packet, Answer Sheet, and Key. It's a bit strange-looking due to the challenges of TeX, but the functionally should be straightforward.

Each line corresponds to one entry, which is either a section header, infoline, or a question. Columns are delimited by `!!` and spaces on either end of a field are trimmed when the data is ingested.

Columns are as follows:
1. **Type:** Currently one of `S` for a Section, `i` for an Infoline, or `Q` for a Question.
2. **Section:** Links the element to one of the section letters defined in `./data/exam-scioly-araneesh-data.sty`, allowing for autosummation of point values. A value in this field is not strictly necessary for Infolines but including it does make it easier to read.
3. **Points:** Number of points for a Question. Automatically appended in the Test Packet, Answer Sheet, and Key. Unused for Sections and Infolines - my convention is to leave it blank on the former and input a 0 on the latter, to aid in readability.
4. **Data, Test Packet:** For an Infoline or Question, this is the text to display on the Test Packet. For a Section, this is invoked before the section header - I use it to set page and column breaks, it may have other more versatile uses as well (try it out at your own risk).
5. **Data, Key:**  For a Section, invoked before the section header for e.g. page/column breaks. For a Question, this can be used to set answer formatting and linebreaks on the Key to match the Answer Sheet. Unused for an Infoline.
6. **Data, Answer Sheet:** For a Section, invoked before the section header for e.g. page/column breaks. For a Question, this can be used to set blank lines and any accompanying text (e.g. units) on the Answer Sheet. Unused for an Infoline.
Note - columns 4, 5, and 6 can include somewhat arbitrary LaTeX commands, e.g. you can do things like `km\textsuperscript{2}`. I haven't rigorously tested the limits of this, TeX can get a little weird with macro handling sometimes and I'm not an expert with it.

The included version of `./data/exam-context.txt` shows some examples of how to use the formatting options provided, using some predefined commands from the class file that satisfy my own use cases.

## Notes

This project is relatively brittle in exchange for efficiency in its somewhat narrow goals. I can get away with this thanks to my extensive event supervising experience, as I have confidence that it meets my event supervising needs consistently. It should work well for most event supervisors (at least, those who are willing/able to use LaTeX), but your mileage may vary.

If you want to bring up feedback or ask questions, I've opened a [thread on the Scioly.org Forums](example.com). Please post any such comments there, as I want to ensure that everyone has easy access to discussions.
