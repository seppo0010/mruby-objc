%{
struct kwtable {const char *name; int id[2]; enum mrb_lex_state_enum state;};
const struct kwtable *mrb_reserved_word(const char *, unsigned int);
static const struct kwtable *reserved_word(const char *, unsigned int);
#define mrb_reserved_word(str, len) reserved_word(str, len)
%}

struct kwtable;
%%
__ENCODING__, {keyword__ENCODING__, keyword__ENCODING__}, EXPR_END
__FILE__,     {keyword__FILE__,     keyword__FILE__},     EXPR_END
__LINE__,     {keyword__LINE__,     keyword__LINE__},     EXPR_END
BEGIN,        {keyword_BEGIN,       keyword_BEGIN},       EXPR_END
END,          {keyword_END,         keyword_END},         EXPR_END
alias,        {keyword_alias,       keyword_alias},       EXPR_FNAME
and,          {keyword_and,         keyword_and},         EXPR_VALUE
begin,        {keyword_begin,       keyword_begin},       EXPR_BEG
break,        {keyword_break,       keyword_break},       EXPR_MID
case,         {keyword_case,        keyword_case},        EXPR_VALUE
class,        {keyword_class,       keyword_class},       EXPR_CLASS
def,          {keyword_def,         keyword_def},         EXPR_FNAME
do,           {keyword_do,          keyword_do},          EXPR_BEG
else,         {keyword_else,        keyword_else},        EXPR_BEG
elsif,        {keyword_elsif,       keyword_elsif},       EXPR_VALUE
end,          {keyword_end,         keyword_end},         EXPR_END
ensure,       {keyword_ensure,      keyword_ensure},      EXPR_BEG
false,        {keyword_false,       keyword_false},       EXPR_END
for,          {keyword_for,         keyword_for},         EXPR_VALUE
if,           {keyword_if,          modifier_if},         EXPR_VALUE
in,           {keyword_in,          keyword_in},          EXPR_VALUE
module,       {keyword_module,      keyword_module},      EXPR_VALUE
next,         {keyword_next,        keyword_next},        EXPR_MID
nil,          {keyword_nil,         keyword_nil},         EXPR_END
not,          {keyword_not,         keyword_not},         EXPR_ARG
or,           {keyword_or,          keyword_or},          EXPR_VALUE
redo,         {keyword_redo,        keyword_redo},        EXPR_END
rescue,       {keyword_rescue,      modifier_rescue},     EXPR_MID
retry,        {keyword_retry,       keyword_retry},       EXPR_END
return,       {keyword_return,      keyword_return},      EXPR_MID
self,         {keyword_self,        keyword_self},        EXPR_END
super,        {keyword_super,       keyword_super},       EXPR_ARG
then,         {keyword_then,        keyword_then},        EXPR_BEG
true,         {keyword_true,        keyword_true},        EXPR_END
undef,        {keyword_undef,       keyword_undef},       EXPR_FNAME
unless,       {keyword_unless,      modifier_unless},     EXPR_VALUE
until,        {keyword_until,       modifier_until},      EXPR_VALUE
when,         {keyword_when,        keyword_when},        EXPR_VALUE
while,        {keyword_while,       modifier_while},      EXPR_VALUE
yield,        {keyword_yield,       keyword_yield},       EXPR_ARG
%%
