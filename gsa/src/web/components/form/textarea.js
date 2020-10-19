/* Copyright (C) 2016-2020 Greenbone Networks GmbH
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Affero General Public License
 * as published by the Free Software Foundation, either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import React, {useState} from 'react';
import {isDefined} from 'gmp/utils/identity';
import PropTypes from 'web/utils/proptypes';

import styled from 'styled-components';

import Theme from 'web/utils/theme';

import withLayout from 'web/components/layout/withLayout';

import {DISABLED_OPACITY} from './field';
import {Marker} from './useFormValidation';

const StyledTextArea = styled.textarea`
  display: block;
  height: auto;
  color: ${Theme.darkGray};
  background-color: ${Theme.white};
  background-image: none;
  border: 1px solid ${Theme.inputBorderGray};
  border-radius: 2px;
  padding: 4px 8px;
  cursor: ${props => (props.disabled ? 'not-allowed' : undefined)};
  background-color: ${props => {
    if (props.hasError) {
      return Theme.lightRed;
    } else if (props.disabled) {
      return Theme.dialogGray;
    }
  }};
  opacity: ${props => (props.disabled ? DISABLED_OPACITY : undefined)};
`;

const TextArea = ({hasError = false, errorContent, title, ...props}) => {
  const [value, setValue] = useState(props.value);
  const notifyChange = val => {
    const {name, onChange, disabled = false} = props;

    if (isDefined(onChange) && !disabled) {
      onChange(val, name);
    }
  };
  const handleChange = event => {
    const val = event.target.value;

    setValue(val);

    notifyChange(val);
  };

  return (
    <React.Fragment>
      <StyledTextArea
        {...props}
        hasError={hasError}
        title={hasError ? errorContent : title}
        value={value}
        onChange={handleChange}
      />
      <Marker isVisible={hasError}>×</Marker>
    </React.Fragment>
  );
};

TextArea.propTypes = {
  disabled: PropTypes.bool,
  errorContent: PropTypes.string,
  hasError: PropTypes.bool,
  name: PropTypes.string,
  title: PropTypes.string,
  value: PropTypes.string,
  onChange: PropTypes.func,
};

export default withLayout()(TextArea);

// vim: set ts=2 sw=2 tw=80:
