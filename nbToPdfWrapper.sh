#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

# Shell script to wrap the jupyter nbconvert and make some minor tex tweaks

# arguments
# 1: basename - name of the file, without the extension. 
# 2: title - Preferred title for the work
# 3: author - Authors

NB=$1.ipynb
TEX=$1.tex
TEMP=.${TEX}
# convert to tex
if [ -f ${NB} ]; then
    jupyter nbconvert --to latex --output=${TEMP} ${NB}

    # replace .png with .pdf, update title and add author
    sed -e 's/.png}/.pdf}/g' -e "s/$1/$2/" -e "/title/a \\\\\author{$3}" ${TEMP} > ${TEX}
    rm ${TEMP}
else
    echo "File ${NB} does not exist..."
fi
